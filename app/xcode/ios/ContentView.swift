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

    func Reload ( ) {
        Task {
            do {
                self.activeData.SetStatus ( downloading: true, loading: true )
                try await self.api.UpdateCache ( connected: self.net.connected )
            } catch {
                self.activeData.SetError ( error: "Could Not Download Update" )
            }
        }
    }
    
    func GetData ( ) {
        if !self.activeData.downloading {
            do {
                if try self.api.cache.CacheExists ( ) {
                    let ordo = try self.api.cache.GetOrdo ( )
                    if ordo.count > 0 {
                        if let prayers = try self.api.cache.GetPrayers ( ) {
                            return self.activeData.SetSuccess ( ordo: ordo, prayers: prayers )
                        }
                    }
                }
                
                if self.net.connected {
                    self.activeData.SetStatus ( downloading: true, loading: true )
                    Task {
                        try await self.api.UpdateCache ( connected: self.net.connected )
                    }
                } else {
                    self.activeData.SetError ( error: "Internet Required to Download Ordo" )
                }
            } catch {
                self.activeData.SetError ( error: "An Error Occured Loading App Data" )
            }
        } else {
            print ( "We don't appear to be downloading..." )
        }
    }

    var body: some View {
        if self.activeData.loading {
            LoadingView ( ).onAppear {
                self.GetData ( )
            }
        } else if self.activeData.error {
            ErrorView ( description: self.activeData.last_err, Callback: self.Reload )
        } else {
            OrdoView ( )
                .environmentObject ( self.net )
        }
    }
}
