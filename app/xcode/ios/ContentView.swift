//
//  ContentView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 12/03/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var activeData: ActiveData
    @ObservedObject var net: NetworkMonitor = NetworkMonitor ( )
    var api: API

    func GetData ( ) {
        do {
            if try self.api.cache.CacheExists ( ) {
                let ordo = try self.api.cache.GetOrdo ( )
                if ordo.count > 0 {
                    if let prayers = try self.api.cache.GetPrayers ( ) {
                        return self.activeData.SetSuccess ( ordo: ordo, prayers: prayers )
                    }
                }
            }

            self.activeData.SetStatus ( downloading: true, loading: true )
            Task {
                do {
                    try await self.api.UpdateCache ( )
                } catch {
                    if self.net.connected {
                        self.activeData.SetError ( error: "Ordo Update Could Not Be Fetched." )
                    }
                }
            }
        } catch {
            self.activeData.SetError ( error: "An Error Occured Loading App Data" )
        }
    }

    var body: some View {
        if !self.net.connected && self.activeData.downloading {
            ErrorView ( description: "No Internet Connection" )
        } else if self.activeData.error {
            ErrorView ( description: self.activeData.last_err )
        } else if self.activeData.loading {
            LoadingView ( ).onAppear {
                self.activeData.SetDownload ( download: 0 )
                Task {
                    try await Task.sleep ( nanoseconds: 1_000_000_000 )
                    self.GetData ( )
                }
            }
                .environmentObject ( self.net )
        } else {
            CommonView ( )
                .environmentObject ( self.net )
        }
    }
}
