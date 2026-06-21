//
//  ActiveData.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 13/12/2023.
//

import SwiftUI
import OrderedCollections

@MainActor
@Observable
class ActiveData {
    private(set) var loading: Bool = true
    private(set) var downloading: Bool = false
    private(set) var error: Bool = false
    private(set) var percentage = 0

    private(set) var last_err = ""
    private(set) var ordo: [ OrdoYear ] = []
    private(set) var prayers: PrayerLanguageData? = nil
    private(set) var locale: LocaleOrdo? = nil
    private(set) var votives: [ VotiveData ]? = nil

    // Pre-built search index: year → flat array of (lowercased combined text, monthIdx, dayIdx)
    private var searchIndex: [ Int: [ (text: String, month: Int, day: Int) ] ] = [ : ]

    func SetSuccess ( ordo: [ OrdoYear ], locale: LocaleOrdo?, prayers: PrayerLanguageData?, votives: [ VotiveData ]? ) {
        self.ordo = ordo
        self.prayers = prayers
        self.locale = locale
        self.votives = votives
        
        self.searchIndex = [ : ]
        for o in self.ordo {
            self.buildSearchIndex ( for: o )
        }
        
        self.SetStatus ( )
    }

    private func buildSearchIndex ( for ordoYear: OrdoYear ) {
        let entries = ordoYear.ordo.enumerated ( ).flatMap { ( mi, month ) in
            month.enumerated ( ).map { ( di, day ) in
                let titles = [ 
                    day.date.day, 
                    day.date.month, 
                    day.date.weekday, 
                    day.date.combined, 
                    day.season.title 
                ] + day.celebrations.flatMap { c in
                    [ c.title, "class \(c.rank)" ] + c.commemorations.map { $0.title }
                } + day.fasting
                return ( text: titles.joined ( separator: " " ).lowercased ( ), month: mi, day: di )
            }
        }
        searchIndex [ ordoYear.year ] = entries
    }
    
    func SetDownload ( download: Int ) {
        self.percentage = download
    }
    
    func SetError ( error: String ) {
        self.last_err = error
        self.SetStatus ( error: true )
    }
    
    func SetStatus ( error: Bool = false, downloading: Bool = false, loading: Bool = false ) {
        self.error = error
        self.downloading = downloading
        self.loading = loading
    }

    func GetIDToday ( ) -> String {
        if let currentYearOrdo = GetYear ( ) {
            return currentYearOrdo.getDay ( month: CurrentMonth ( ), day: CurrentDay ( ) ).date.combined
        }
        return ""
    }
    
    func GetCountries ( ) -> OrderedSet<String> {
        return OrderedSet ( locale?.feasts.countries ?? [] )
    }
    
    func GetDioceses ( country: String ) -> OrderedSet<String> {
        return OrderedSet ( locale?.feasts.locale [ country ]?.dioceses ?? [] )
    }
    
    func GetDioceseLocale ( country: String, diocese: String ) -> [ LocaleData ] {
        return locale?.feasts.locale [ country ]?.locale [ diocese ] ?? []
    }
    
    private func LoadYearSync ( year: Int ) -> OrdoYear? {
        let resourceName = "\(year)"
        guard let url = Bundle.main.url ( forResource: resourceName, withExtension: "zlib", subdirectory: "data/ordo" )
             ?? Bundle.main.url ( forResource: resourceName, withExtension: "json", subdirectory: "data/ordo" )
             ?? Bundle.main.url ( forResource: resourceName, withExtension: "zlib", subdirectory: "data" )
             ?? Bundle.main.url ( forResource: resourceName, withExtension: "json", subdirectory: "data" )
             ?? Bundle.main.url ( forResource: resourceName, withExtension: "zlib" )
             ?? Bundle.main.url ( forResource: resourceName, withExtension: "json" )
        else { return nil }
        
        do {
            let data = try Data ( contentsOf: url )
            let finalData: Data
            if url.pathExtension == "zlib" {
                finalData = try ( data as NSData ).decompressed ( using: .zlib ) as Data
            } else {
                finalData = data
            }
            return try JSONDecoder ( ).decode ( OrdoYear.self, from: finalData )
        } catch {
            print ( "Failed to load year \(year): \(error)" )
            return nil
        }
    }

    func GetYear ( year: Int = CurrentYear ( ) ) -> OrdoYear? {
        if let existing = self.ordo.first ( where: { $0.year == year } ) {
            return existing
        }
        
        if let newYear = LoadYearSync ( year: year ) {
            self.ordo.append ( newYear )
            self.buildSearchIndex ( for: newYear )
            return newYear
        }
        return nil
    }
    
    // Snapshot for off-main-thread search
    func getSearchSnapshot ( year: Int ) -> ( entries: [ (text: String, month: Int, day: Int) ], months: [ [ OrdoDay ] ] )? {
        guard let ordoYear = GetYear ( year: year ),
              let entries = searchIndex [ year ] else { return nil }
        return ( entries, ordoYear.ordo )
    }
}
