//
//  OrdoAPI.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 02/07/2023.
//

import SwiftUI

class OrdoAPI: ObservableObject {
    private let file: String = "ordo.data", url = "ordo.php"
    @Published private ( set ) var res: ResultAPI <OrdoMonth>!
    private var api: API = API ( )
    @ObservedObject private var net: NetworkMonitor = NetworkMonitor ( )

    init ( ) {
        self.res = self.GetCache ( ) // Go To Loading If Cache Does Not Exist
        if case .success ( _ ) = self.res {
            UserDefaults.standard.set ( 2, forKey: "go-to-today" )
        }
    }
    
    // Update The Status Of The Ordo Calendar Data
    func Update ( use_cache: Bool = true ) async {
        for i in Int ( CurrentYear ( ) )!...Int ( CurrentYear ( ) )! + 10 {
            let file = "ordo-\(i).data"

            if i == Int ( CurrentYear ( ) ) && use_cache {
                if case .success ( _ ) = self.res {
                    print ( "Ordo Data Already At Status Successful" )
                    continue
                }
                UserDefaults.standard.set ( 3, forKey: "go-to-today" )
            } else if use_cache {
                if self.api.CacheExists ( name: file ) {
                    continue
                }
            }

            let now: String = FormatDate ( time: true ).string ( from: .now )
            UserDefaults.standard.set ( now, forKey: "last-update" )
            let queries = [
                URLQueryItem ( name: "year", value: String ( i ) )
            ]
           
            if i == Int ( CurrentYear ( ) ) {
                let data = await self.api.GetAPI ( use_cache: use_cache, file: file, url: self.url, type: OrdoMonth.self, queries: queries )
                DispatchQueue.main.async {
                    self.res = data
                }
            } else {
                Task {
                    await self.api.GetAPI ( use_cache: use_cache, file: file, url: self.url, type: OrdoMonth.self, queries: queries )
                }
            }
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
    func GetResult ( search: String = "" ) -> OrdoMonth {
        var result = DUMMY_ORDO
        if case let .success ( res ) = self.res {
            result = res
            if search != "" {
                for month in Calendar.current.monthSymbols {
                    result [ month ] = self.Filter ( search: search, data: result [ month ]! )
                }
            }
        }
        return result
    }

    // Get Cache Data, Ignore Internet
    func GetCache ( ) -> ResultAPI <OrdoMonth> {
        do {
            if CurrentDay ( ) == 1 && CurrentMonth ( ) == "January" {
                try self.DeleteCache ( file: "ordo-" + String ( Int ( CurrentYear ( ) )! - 1 ) + ".data" )
            } else if self.net.connected && config.DataStale ( ) {
                for i in Int ( CurrentYear ( ) )!...Int ( CurrentYear ( ) )! + 10 {
                    let file = "ordo-\(String(i)).data"
                    try self.DeleteCache ( file: file )
                }
            }
            let file: String = "ordo-\( CurrentYear ( ) ).data"
            return .success ( try self.api.GetCache ( file: file, type: OrdoMonth.self ) )
        } catch ErrorAPI.fetching {
            UserDefaults.standard.set ( 1, forKey: "go-to-today" )
            return .loading ( DUMMY_ORDO )
        } catch {
            return .failure ( error.localizedDescription )
        }
    }
    
    func DeleteCache ( file: String ) throws {
        let container = FileManager.default.containerURL ( forSecurityApplicationGroupIdentifier: "group.mfrankland.ordo-62.contents" )!
        try FileManager.default.removeItem ( atPath: container.appending ( path: file, directoryHint: .notDirectory ).path )
    }
    
    // Reset Ordo to Progress View
    func SetLoading ( ) {
        self.res = .loading ( DUMMY_ORDO )
    }
    
    // Reload on Error
    func ErrorRetry ( ) {
        DispatchQueue.main.async {
            Task {
                self.SetLoading ( )
                try await Task.sleep ( nanoseconds: UInt64 ( 2 * Double ( NSEC_PER_SEC ) ) )
                await self.Update ( )
            }
        }
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
