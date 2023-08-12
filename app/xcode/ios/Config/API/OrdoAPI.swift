//
//  OrdoAPI.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 02/07/2023.
//

import Foundation

class OrdoAPI: ObservableObject {
    private let file: String = "ordo.data", url = "ordo.php"
    @Published private ( set ) var res: ResultAPI <OrdoData>!
    private var api: API = API ( )
    
    init ( ) {
        self.res = self.GetCache ( ) // Go To Loading If Cache Does Not Exist
        if case .success ( _ ) = self.res {
            UserDefaults.standard.set ( 2, forKey: "go-to-today" )
        }
    }
    
    // Update The Status Of The Ordo Calendar Data
    func Update ( use_cache: Bool = true ) async {
        if use_cache {
            if case .success ( _ ) = self.res {
                print ( "Ordo Data Already At Status Successful" )
                return
            }
        }
        
        if UserDefaults.standard.string ( forKey: "year" ) ?? CurrentYear ( ) == CurrentYear ( ) {
            UserDefaults.standard.set ( 3, forKey: "go-to-today" )
        }

        let now: String = FormatDate ( time: true ).string ( from: .now )
        UserDefaults.standard.set ( now, forKey: "last-update" )
        
        let queries: [ URLQueryItem ] = [
            URLQueryItem ( name: "year", value: UserDefaults.standard.string ( forKey: "year" ) ?? CurrentYear ( ) ),
            URLQueryItem ( name: "timezone", value: TimeZone.current.identifier )
        ]
        
        let data = await self.api.GetAPI ( file: self.file, url: self.url, type: OrdoData.self, queries: queries )
        DispatchQueue.main.async {
            self.res = data
        }
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
    func BackToCurrentYear ( ) {
        UserDefaults.standard.set ( CurrentYear ( ), forKey: "year" )
        self.res = self.GetCache ( )
    }

    // Get Cache Data, Ignore Internet
    func GetCache ( ) -> ResultAPI <OrdoData> {
        do {
            return .success ( try self.api.GetCache ( file: self.file, type: OrdoData.self ) )
        } catch ErrorAPI.fetching {
            UserDefaults.standard.set ( 1, forKey: "go-to-today" )
            return .loading ( DUMMY_ORDO )
        } catch {
            return .failure ( error.localizedDescription )
        }
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
