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
        try cache.DeleteAll ( )
        let locale = try await LocaleRequest ( )
        let votives = try await VotiveRequest ( )
        self.activeData.SetDownload ( download: 4 )

        let prayers = try await PrayerRequest ( )
        self.activeData.SetDownload ( download: 8 )

        let startYear = 2023
        let endYear = 2123
        var ordoMap: [ Int : OrdoYear ] = [ : ]
        
        try await withThrowingTaskGroup ( of: ( Int, OrdoYear ).self ) { group in
            for i in startYear...endYear {
                group.addTask {
                    let res = try await self.FetchOrdo ( year: String ( i ) )
                    return ( i, res )
                }
            }
            
            var completedCount = 0
            for try await ( year, yearOrdo ) in group {
                ordoMap [ year ] = yearOrdo
                completedCount += 1
                let progress = Int ( ( Double ( completedCount ) / Double ( endYear - startYear + 1 ) ) * 90.0 ) + 8
                self.activeData.SetDownload ( download: progress )
            }
        }
        
        let ordo = ( startYear...endYear ).compactMap { ordoMap [ $0 ] }
        for o in ordo {
            cache.Insert ( ordo: o )
        }
        
        cache.Save ( )
        let version = Bundle.main.infoDictionary? [ "CFBundleShortVersionString" ] as? String ?? ""
        UserDefaults.standard.set ( version, forKey: "version" )
        self.activeData.SetSuccess ( ordo: ordo, locale: locale, prayers: prayers, votives: votives )
        WidgetCenter.shared.reloadAllTimelines ( )
    }
    
    func FetchOrdo ( year: String ) async throws -> OrdoYear {
        let data = try await self.HTTP ( url: "ordo/\(year).json" )
        return try self.Decode ( data: data, type: OrdoYear.self )
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
        let cleanPath = url.replacingOccurrences ( of: ".json", with: "" )
        let components = cleanPath.components ( separatedBy: "/" )
        let resourceName = components.last ?? ""
        
        var fileURL: URL? = nil
        
        // 1. Try absolute root bundle
        fileURL = Bundle.main.url ( forResource: resourceName, withExtension: "json" )
        
        // 2. Try target folder reference (like "data/ordo")
        if fileURL == nil {
            let subDirectory = "data" + ( components.count > 1 ? "/" + components.dropLast ( ).joined ( separator: "/" ) : "" )
            fileURL = Bundle.main.url ( forResource: resourceName, withExtension: "json", subdirectory: subDirectory )
        }
        
        // 3. Try direct subdirectory (like "ordo" or "data")
        if fileURL == nil && components.count > 1 {
            let subDirectory = components.dropLast ( ).joined ( separator: "/" )
            fileURL = Bundle.main.url ( forResource: resourceName, withExtension: "json", subdirectory: subDirectory )
        }
        
        // 4. Try inside "data" folder directly
        if fileURL == nil {
            fileURL = Bundle.main.url ( forResource: resourceName, withExtension: "json", subdirectory: "data" )
        }
        
        guard let finalURL = fileURL else {
            throw APIError.fetching ( "Local file not found: \(url)" )
        }
        
        do {
            return try Data ( contentsOf: finalURL )
        } catch {
            throw APIError.fetching ( "Could not read file: \(error.localizedDescription)" )
        }
    }
}
