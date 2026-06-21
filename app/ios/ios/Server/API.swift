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

    @MainActor
    func UpdateCache ( ) async throws {
        let locale = try await LocaleRequest ( )
        let votives = try await VotiveRequest ( )
        self.activeData.SetDownload ( download: 40 )

        let prayers = try await PrayerRequest ( )
        self.activeData.SetDownload ( download: 80 )

        // OrdoYears are loaded dynamically by ActiveData.GetYear(year:) when requested.
        // We initialize with an empty array (or just the current year if we wanted to),
        // but since GetYear will dynamically fetch it, an empty array is fine.
        let ordo: [ OrdoYear ] = []
        
        cache.Save ( )
        let version = Bundle.main.infoDictionary? [ "CFBundleShortVersionString" ] as? String ?? ""
        UserDefaults.standard.set ( version, forKey: "version" )
        self.activeData.SetSuccess ( ordo: ordo, locale: locale, prayers: prayers, votives: votives )
        WidgetCenter.shared.reloadAllTimelines ( )
    }
    
    func FetchOrdo ( year: String ) async throws -> OrdoYear {
        let data = try await self.HTTP ( url: "ordo/\(year).zlib" )
        return try self.Decode ( data: data, type: OrdoYear.self )
    }
    
    func GetCurrent ( ) async throws -> OrdoYear {
        return try await self.OrdoRequest ( year: String ( CurrentYear ( ) ) )
    }
    
    private func Decode <T:Decodable> ( data: Data, type: T.Type ) throws -> T {
        return try JSONDecoder ( ).decode ( T.self, from: data )
    }
    
    private func OrdoRequest ( year: String ) async throws -> OrdoYear {
        let data = try await self.HTTP ( url: "ordo/\(year).zlib" )
        let json: OrdoYear = try self.Decode ( data: data, type: OrdoYear.self )
        return json
    }
    
    private func PrayerRequest ( ) async throws -> PrayerLanguageData {
        let data = try await self.HTTP ( url: "prayers.json" )
        let json: PrayerLanguageData = try self.Decode ( data: data, type: PrayerLanguageData.self )
        cache.Insert ( prayers: json )
        return json
    }
    
    func LocaleRequest ( ) async throws -> LocaleOrdo {
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
        let cleanPath = url.replacingOccurrences ( of: ".json", with: "" ).replacingOccurrences ( of: ".zlib", with: "" )
        let components = cleanPath.components ( separatedBy: "/" )
        let resourceName = components.last ?? ""
        let isOrdo = url.contains ( "ordo/" )
        let ext = isOrdo ? "zlib" : "json"
        
        var fileURL: URL? = nil
        
        fileURL = Bundle.main.url ( forResource: resourceName, withExtension: ext )
        
        if fileURL == nil {
            let subDirectory = "data" + ( components.count > 1 ? "/" + components.dropLast ( ).joined ( separator: "/" ) : "" )
            fileURL = Bundle.main.url ( forResource: resourceName, withExtension: ext, subdirectory: subDirectory )
        }
        
        if fileURL == nil && components.count > 1 {
            let subDirectory = components.dropLast ( ).joined ( separator: "/" )
            fileURL = Bundle.main.url ( forResource: resourceName, withExtension: ext, subdirectory: subDirectory )
        }
        
        if fileURL == nil {
            fileURL = Bundle.main.url ( forResource: resourceName, withExtension: ext, subdirectory: "data" )
        }
        
        if fileURL == nil && isOrdo {
            fileURL = Bundle.main.url ( forResource: resourceName, withExtension: "json", subdirectory: "data/ordo" ) ??
                      Bundle.main.url ( forResource: resourceName, withExtension: "json", subdirectory: "data" ) ??
                      Bundle.main.url ( forResource: resourceName, withExtension: "json" )
        }
        
        guard let finalURL = fileURL else {
            throw APIError.fetching ( "Local file not found: \(url)" )
        }
        
        do {
            let data = try Data ( contentsOf: finalURL )
            if finalURL.pathExtension == "zlib" {
                return try ( data as NSData ).decompressed ( using: .zlib ) as Data
            }
            return data
        } catch {
            throw APIError.fetching ( "Could not read file: \(error.localizedDescription)" )
        }
    }
}
