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
        self.res = .loading
//        Task {
//            self.res = await self.GetCache ( year: CurrentYear ( ) ) // Go To Loading If Cache Does Not Exist
//        }
    }
    
    // Update The Status Of The Ordo Calendar Data
    func Update ( use_cache: Bool = false ) async {
        for i in CurrentYear ( )...CurrentYear ( ) + 10 {
            let file = "ordo-\(i).data"

            if i == CurrentYear ( ) && use_cache {
                if case .success ( _ ) = self.res {
                    print ( "Ordo Data Already At Status Successful" )
                    continue
                }
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
           
            if i == CurrentYear ( ) {
                self.res = await self.api.GetAPI ( use_cache: use_cache, file: file, url: self.url, type: OrdoMonth.self, queries: queries )
            } else {
                _ = await self.api.GetAPI ( use_cache: use_cache, file: file, url: self.url, type: OrdoMonth.self, queries: queries )
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
        if case let .success ( res ) = self.res {
            var result: OrdoMonth = res
            if search != "" {
                for month in result.keys {
                    result [ month ] = self.Filter ( search: search, data: result [ month ]! )
                }
            }
            return result
        }
        return DUMMY_ORDO
    }

    // Get Cache Data, Ignore Internet
    func GetCache ( year: Int ) async -> ResultAPI <OrdoMonth> {
        do {
            if config.settings == nil && self.net.connected {
                await config.GetSettings ( )
            }
            if self.api.CacheExists ( name: "ordo.data" ) {
                try self.DeleteCache ( file: "ordo.data" )
            }
            if CurrentDay ( ) == 1 && CurrentMonth ( ) == "Jan" {
                try self.DeleteCache ( file: "ordo-\( CurrentYear ( ) - 1 ).data" )
            } else if self.net.connected && config.DataStale ( ) {
                for i in CurrentYear ( )...CurrentYear ( ) + 10 {
                    let file = "ordo-\( i ).data"
                    try self.DeleteCache ( file: file )
                }
            }
            let file: String = "ordo-\( year ).data"
            return .success ( try self.api.GetCache ( file: file, type: OrdoMonth.self ) )
        } catch ErrorAPI.fetching {
            return .loading
        } catch {
            return .failure ( error.localizedDescription )
        }
    }

    // Delete Cache From Default App Group
    private func DeleteCache ( file: String ) throws {
        let container = FileManager.default.containerURL ( forSecurityApplicationGroupIdentifier: "group.mfrankland.ordo-62.contents" )!
        try FileManager.default.removeItem ( atPath: container.appending ( path: file, directoryHint: .notDirectory ).path )
    }

    // Check If Loading
    func GetLoading ( ) -> Bool {
        if case .loading = self.res {
            return true
        }
        return false
    }
    
    // Reload on Error
    func ErrorRetry ( ) {
        DispatchQueue.main.async {
            Task {
                self.res = .loading
                try await Task.sleep ( nanoseconds: UInt64 ( 2 * Double ( NSEC_PER_SEC ) ) )
                await self.Update ( )
            }
        }
    }
    
    // Filter Celebration Data If Search Contained In Title(s)
    private func Filter ( search: String = "", data: [ OrdoDay ] ) -> [ OrdoDay ] {
        return data.filter {
            if $0.season.title.localizedCaseInsensitiveContains ( search ) {
                return true
            }
            for celebration in $0.celebrations {
                if celebration.title.localizedCaseInsensitiveContains ( search ) {
                    return true
                }
                
                if celebration.commemorations.contains ( where: { $0.title.localizedCaseInsensitiveContains ( search ) } ) {
                    return true
                }
            }
            return false
        }
    }
}
