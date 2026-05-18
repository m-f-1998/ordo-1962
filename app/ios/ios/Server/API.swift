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
    var cache: Cache = Cache ( )
    private var activeData: ActiveData
    
    init ( activeData: ActiveData ) {
        self.activeData = activeData
    }

    func UpdateCache ( ) async throws {
        try cache.DeleteAll ( )
        let locale = try await LocaleRequest ( )
        let votives = try await VotiveRequest ( )
        await MainActor.run {
            self.activeData.SetDownload ( download: 4 )
        }

        let prayers = try await PrayerRequest ( )
        await MainActor.run {
            self.activeData.SetDownload ( download: 8 )
        }
        var ordo: [ OrdoYear ] = []
        for i in CurrentYear ( )...CurrentYear ( ) + 5 {
            print ( "Downloading \(i)..." )
            ordo.append ( try await self.OrdoRequest ( year: String ( i ) ) )
            await MainActor.run {
                self.activeData.SetDownload ( download: ( i + 1 - CurrentYear ( ) ) * 16 )
            }
        }
        cache.Save ( )
        let version = Bundle.main.infoDictionary? [ "CFBundleShortVersionString" ] as? String ?? ""
        UserDefaults.standard.set ( version, forKey: "version" )
        await MainActor.run { [ ordo, prayers, locale, votives ] in
            self.activeData.SetSuccess ( ordo: ordo, locale: locale, prayers: prayers, votives: votives )
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
        let data = try await self.HTTP ( url: "ordo/\(year).json" )
        let json: OrdoYear = try self.Decode ( data: data, type: OrdoYear.self )
        cache.Insert ( ordo: json )
        return json
    }
    
    private func PrayerRequest ( ) async throws -> PrayerLanguageData {
        let data = try await self.HTTP ( url: "prayers.json" )
        let json: PrayerLanguageData = try self.Decode ( data: data, type: PrayerLanguageData.self )
        cache.Insert ( prayers: json )
        return json
    }
    
    private func LocaleRequest ( ) async throws -> LocaleOrdo {
        let data = try await self.HTTP ( url: "locale.json" )
        let json: LocaleOrdo = try self.Decode ( data: data, type: LocaleOrdo.self )
        cache.Insert ( locale: json )
        return json
    }
    
    private func VotiveRequest ( ) async throws -> [ VotiveData ] {
        let data = try await self.HTTP ( url: "votives.json" )
        let json: [ VotiveData ] = try self.Decode ( data: data, type: [ VotiveData ].self )
        cache.Insert ( votives: json )
        return json
    }

    private func HTTP ( url: String ) async throws -> Data {
        let base = "https://m-f-1998.github.io/ordo-1962/data/"
        guard let requestURL = URL ( string: base + url ) else {
            throw APIError.fetching ( "Invalid URL: \(url)" )
        }

        var request = URLRequest ( url: requestURL )
        request.setValue ( "application/json", forHTTPHeaderField: "Accept" )
        request.timeoutInterval = 25

        do {
            let ( data, response ) = try await URLSession.shared.data ( for: request )
            let statusCode: Int? = ( response as? HTTPURLResponse )?.statusCode

            guard statusCode == 200 else { throw APIError.fetching ( "HTTP Status Code \(statusCode ?? -1)" ) }
            return data
        } catch {
            throw APIError.fetching ( "Network Timeout" )
        }
    }
}
