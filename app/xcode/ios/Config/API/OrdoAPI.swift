//
//  OrdoAPI.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 02/07/2023.
//

import Foundation

class OrdoAPI: ObservableObject {
    private let file: String = "ordo.data", url = "ordo.php"
    @Published private ( set ) var res: ResultAPI <OrdoData> = .loading ( DUMMY_ORDO )
    private var api: API
    
    init ( config: FirebaseConfig ) {
        self.api = API ( config: config )
    }
    
    // Update The Status Of The Ordo Calendar Data
    func Update ( ignore_cache: Bool = false ) async {
        let now: String = FormatDate ( time: true ).string ( from: .now )
        UserDefaults.standard.set ( now, forKey: "lastUpdate" )

        let new_year: Bool = CurrentDay ( ) == 1 && CurrentMonth ( ) == "January"
        let queries: [ URLQueryItem ] = [
            URLQueryItem ( name: "year", value: UserDefaults.standard.string ( forKey: "year" ) ?? CurrentYear ( ) ),
            URLQueryItem ( name: "timezone", value: TimeZone.current.identifier )
        ]

        let data = await self.api.GetData ( ignore_cache: ignore_cache, new_year: new_year, wait: true, file: self.file, url: self.url, type: OrdoData.self, queries: queries )
        DispatchQueue.main.async { self.res = data }
    }
    
    // Get ID Of Today's Feast
    func GetIDToday ( ) -> String? {
        if case let .success ( res ) = self.res {
            return res [ CurrentMonth ( ) ]! [ CurrentDay ( ) - 1 ].id
        }
        return nil
    }

    // Get Data, Filtered If Search
    func GetResult ( search: String = "" ) -> OrdoData {
        var result = DUMMY_ORDO
        if case let .success ( res ) = self.res {
            result = res
            if ( search != "" ) {
                for month in Calendar.current.monthSymbols {
                    result [ month ] = self.Filter ( search: search, data: result [ month ]! )
                }
            }
        }
        return result
    }
    
    // Go Back To Current Year
    func BackToCurrentYear ( ) async {
        UserDefaults.standard.set ( CurrentYear ( ), forKey: "year" )
        let data: ResultAPI <OrdoData> = await self.GetCache ( )
        DispatchQueue.main.async { self.res = data }
    }

    // Get Cache Data, Ignore Internet
    func GetCache ( ) async -> ResultAPI <OrdoData> {
        return await self.api.GetData ( just_cache: true, wait: false, file: self.file, url: self.url, type: OrdoData.self )
    }
    
    // Reset Ordo to Progress View
    func SetLoading ( ) {
        self.res = .loading ( DUMMY_ORDO )
    }
    
    // Filter Celebration Data If Search Contained In Title(s)
    private func Filter ( search: String = "", data: [ CelebrationData ] ) -> [ CelebrationData ] {
        return data.filter {
            for celebration in $0.celebrations {
                if celebration.title.lowercased ( ).contains ( search.lowercased ( ) ) {
                    return true
                }
                
                if let commemorations = celebration.commemorations {
                    for commemoration in commemorations {
                        if commemoration.title.lowercased ( ).contains ( search.lowercased ( ) ) {
                            return true
                        }
                    }
                }
            }
            if let season = $0.season {
                if season.title.lowercased ( ).contains ( search.lowercased ( ) ) {
                    return true
                }
            }
            return false
        }
    }
}
