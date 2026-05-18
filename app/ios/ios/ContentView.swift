//
//  ContentView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 12/03/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(ActiveData.self) var activeData
    @Environment(NetworkMonitor.self) var net
    var api: API

    func GetData ( ) {
        do {
            guard try self.api.cache.CacheExists ( predicate: #Predicate<OrdoYear> { year in true } ) else {
                self.activeData.SetStatus ( downloading: true, loading: true )
                Task {
                    do {
                        try await self.api.UpdateCache ( )
                    } catch {
                        print ( error )
                        if self.net.connected {
                            self.activeData.SetError ( error: "Ordo Update Could Not Be Fetched." )
                        }
                    }
                }
                return
            }
            let ordo = try self.api.cache.GetOrdo ( predicate: #Predicate<OrdoYear> { year in true } )
            guard !ordo.isEmpty,
                  let prayers = try self.api.cache.GetPrayers ( ),
                  let locale = try self.api.cache.GetLocale ( ),
                  let votives = try self.api.cache.GetVotives ( ) else {
                self.activeData.SetError ( error: "An Error Occurred Loading App Data" )
                return
            }
            self.activeData.SetSuccess ( ordo: ordo, locale: locale, prayers: prayers, votives: votives )
        } catch {
            self.activeData.SetError ( error: "An Error Occurred Loading App Data" )
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
                    try? await Task.sleep ( for: .seconds ( 1 ) )
                    self.GetData ( )
                }
            }
        } else {
            CommonView ( )
        }
    }
}
