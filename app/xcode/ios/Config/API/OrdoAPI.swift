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
    
    func GetResult ( search: String = "" ) -> OrdoData {
        if case let .success ( ordo_res ) = self.res {
            if ( search != "" ) {
                var data = ordo_res
                for month in ordo_res {
                    let res = ordo_res [ month.key ]!
                    data [ month.key ] = res.filter {
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
                return data
            } else {
                return ordo_res
            }
        } else {
            return DUMMY_ORDO
        }
    }

    // Update The Status Of The Ordo Calendar Data
    func Update ( ignore_cache: Bool = false ) async {
        let now: String = FormatDate ( time: true ).string ( from: .now )
        UserDefaults.standard.set ( now, forKey: "lastUpdate" )

        let new_year = CurrentDay ( ) == 1 && CurrentMonth ( ) == "January"
        let queries = [
            URLQueryItem ( name: "year", value: UserDefaults.standard.string ( forKey: "year" ) ?? "2023" ),
            URLQueryItem ( name: "timezone", value: TimeZone.current.identifier )
        ]

        let data = await api.GetData ( ignore_cache: ignore_cache, new_year: new_year, wait: true, file: file, url: url, type: OrdoData.self, queries: queries )
        DispatchQueue.main.async { self.res = data }
    }
    
    func BackToCurrentYear ( ) async {
        UserDefaults.standard.set ( "2023", forKey: "year" )
        let data = await api.GetData ( just_cache: true, wait: false, file: file, url: url, type: OrdoData.self )
        DispatchQueue.main.async { self.res = data }
    }
    
    func GetCache ( ) async -> ResultAPI<OrdoData> {
        return await self.api.GetData ( just_cache: true, wait: false, file: self.file, url: self.url, type: OrdoData.self )
    }
    
    // Reset Ordo to Progress View
    func SetLoading ( ) {
        res = .loading ( DUMMY_ORDO )
    }
}
