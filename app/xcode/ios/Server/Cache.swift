//
//  Cache.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 13/12/2023.
//

import SwiftUI
import SwiftData

enum CacheStatus {
    case valid ( OrdoYear, PrayerLanguageData ), deleted, missing
}

class Cache {
    private var container: ModelContainer!
    private var context: ModelContext!
        
    init ( ) {
        do {
            let configuration = ModelConfiguration ( groupContainer: .identifier ( "group.mfrankland.ordo-62.contents" ) )
            self.container = try ModelContainer ( for: OrdoYear.self, PrayerLanguageData.self, configurations: configuration )
            self.context = ModelContext ( container )
        } catch {
            print ( error )
            print ( "Error: Cache Couldn't Be Created" )
        }
    }
    
    func GetOrdo ( predicate: Predicate<OrdoYear> = #Predicate<OrdoYear> { year in true } ) throws -> [ OrdoYear ] {
        let descriptor = FetchDescriptor <OrdoYear> ( predicate: predicate, sortBy: [ SortDescriptor ( \.year ) ] )
        let data = try self.context.fetch ( descriptor )
        if data.count > 0 && data [ 0 ].year == CurrentYear ( ) {
            if Calendar.current.dateComponents ( [ .month ], from: data [ 0 ].date, to: Date ( ) ).month ?? 0 < 2 {
                return data
            }
        }
        return [ ]
    }
    
    func GetPrayers ( ) throws -> PrayerLanguageData? {
        let descriptor = FetchDescriptor <PrayerLanguageData> ( )
        let data = try self.context.fetch ( descriptor )
        if data.count > 0 {
            return data [ 0 ]
        }
        return nil
    }
    
    func GetContainer ( ) -> ModelContainer {
        return container
    }
    
    func CacheExists ( predicate: Predicate<OrdoYear> = #Predicate<OrdoYear> { year in true } ) throws -> Bool {
        let ordo = try GetOrdo ( predicate: predicate )
        if ( try GetPrayers ( ) ) != nil {
            return ordo.count == 6 && ordo [ 0 ].year == CurrentYear ( )
        }
        return false
    }

    func DeleteAll ( ) throws {
        let descriptor = FetchDescriptor <OrdoYear> ( )
        try self.context.fetch ( descriptor ).forEach { res in
            print ( "Delete Ordo Data..." )
            self.context.delete ( res )
        }
        if let prayers = try GetPrayers ( ) {
            print ( "Delete Prayers Data..." )
            self.context.delete ( prayers )
        }
        self.Save ( )
    }

    func Insert ( prayers: PrayerLanguageData ) {
        self.context.insert ( prayers )
    }
    
    func Insert ( ordo: OrdoYear ) {
        self.context.insert ( ordo )
    }
    
    func Save ( ) {
        do {
            try self.context.save()
        } catch {
            print ( error )
            print ( "Could Not Save Cache State" )
        }
    }
}
