//
//  API.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 13/12/2023.
//

import SwiftUI
import WidgetKit

enum APIError: Error {
    case fetching ( String )
}

class API {
    @State var cache: Cache = Cache ( )
    private var activeData: ActiveData
    
    init ( activeData: ActiveData ) {
        self.activeData = activeData
    }

    func UpdateCache ( ) async throws {
        try cache.DeleteAll ( )
        let locale = try await LocaleRequest ( )
        DispatchQueue.main.async {
            self.activeData.SetDownload ( download: 4 )
        }

        let prayers = try await PrayerRequest ( )
        DispatchQueue.main.async {
            self.activeData.SetDownload ( download: 8 )
        }
        var ordo: [ OrdoYear ] = []
        for i in CurrentYear ( )...CurrentYear ( ) + 5 {
            print ( "Downloading \(i)..." )
            ordo.append ( try await self.OrdoRequest ( year: String ( i ) ) )
            DispatchQueue.main.async {
                self.activeData.SetDownload ( download: ( i + 1 - CurrentYear ( ) ) * 16 )
            }
        }
        cache.Save ( )
        let version = Bundle.main.infoDictionary? [ "CFBundleShortVersionString" ] as? String ?? ""
        UserDefaults.standard.set ( version, forKey: "version" )
        await MainActor.run { [ ordo, prayers ] in
            self.activeData.SetSuccess ( ordo: ordo, locale: locale, prayers: prayers )
            WidgetCenter.shared.reloadAllTimelines ( )
        }
    }
    
    func GetCurrent ( ) async throws -> OrdoYear {
        return try await self.OrdoRequest ( year: String ( CurrentYear ( ) ) )
    }
    
    private func Decode <T:Decodable> ( data: Data, type: T.Type ) throws -> T {
        return try JSONDecoder ( ).decode ( T.self, from: data )
    }
    
    private func OrdoRequest ( year: String ) async throws -> OrdoYear {
        let queries = [
            URLQueryItem ( name: "year", value: year )
        ]
        let data = try await self.HTTP ( queries: queries, url: "ordo.php" )
        let json: OrdoYear = try self.Decode ( data: data, type: OrdoYear.self )
        cache.Insert ( ordo: json )
        return json
    }
    
    private func PrayerRequest ( ) async throws -> PrayerLanguageData {
        let data = try await self.HTTP ( queries: [], url: "prayers.php" )
        let json: PrayerLanguageData = try self.Decode ( data: data, type: PrayerLanguageData.self )
        cache.Insert ( prayers: json )
        return json
    }
    
    private func LocaleRequest ( ) async throws -> LocaleOrdo {
        let data = try await self.HTTP ( queries: [], url: "locale.php" )
        let json: LocaleOrdo = try self.Decode ( data: data, type: LocaleOrdo.self )
        cache.Insert ( locale: json )
        return json
    }

    private func HTTP ( queries: [ URLQueryItem ], url: String ) async throws -> Data {
        var body: URLComponents = URLComponents ( string: "https://matthewfrankland.co.uk/ordo-1962/v1.3/\(url)" )!
        body.queryItems = queries
        body.percentEncodedQuery = body.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        var request = URLRequest(url: body.url!)
        request.setValue ( "application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type" )
        request.setValue ( "application/json", forHTTPHeaderField: "Accept" )
        request.timeoutInterval = 25
        
        do {
            let ( data, response ) = try await URLSession.shared.data ( for: request )
            let status_code: Int? = ( response as? HTTPURLResponse )?.statusCode

            guard status_code == 200 else { throw APIError.fetching ( "HTTP Status Code \(status_code ?? -1)" ) }
            return data
        } catch {
            throw APIError.fetching ( "Network Timeout" )
        }
    }
}
