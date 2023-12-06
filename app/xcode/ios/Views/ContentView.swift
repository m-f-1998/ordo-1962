//
//  ContentView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 12/03/2023.
//

import SwiftUI

struct ContentView: View {
    private let app_url: String = "itms-apps://itunes.apple.com/app/6450934181"

    @ObservedObject var net: NetworkMonitor = NetworkMonitor ( )
    @ObservedObject var ordo: OrdoAPI = OrdoAPI ( )
    @ObservedObject var prayers: PrayerAPI = PrayerAPI ( )
    
    @State private var tab_selection: Int = 0
    @State private var data_stale_alert_shown: Bool = false
    
    @State private var second_tap: Bool = false
    var handler: Binding<Int> { Binding (
        get: { self.tab_selection },
        set: {
            if $0 == self.tab_selection {
                self.second_tap = true
            }
            self.tab_selection = $0
        }
    ) }

    init ( ) {
        if UserDefaults.standard.string ( forKey: "prayers-lang" ) == nil {
            UserDefaults.standard.set ( "English", forKey: "prayers-lang" )
        }
        
        if UserDefaults.standard.string ( forKey: "propers-lang" ) == nil {
            UserDefaults.standard.set ( "English", forKey: "propers-lang" )
        }
    }
    
    func reload ( ) {
        self.prayers.ErrorRetry ( )
        self.ordo.ErrorRetry ( )
    }

    var body: some View {
        VStack ( spacing: 0 ) {
            if case let .failure ( error ) = ordo.res {
                ErrorView ( description: error, Callback: self.reload )
            } else if case let .failure ( error ) = prayers.res {
                ErrorView ( description: error, Callback: self.reload )
            } else {
                TabView ( selection: handler ) {
                    Ordo ( second_tap: self.$second_tap  )
                        .tabItem {
                            Label ( "Ordo", systemImage: "calendar" )
                        }
                        .tag ( 0 )
                    Prayer ( )
                        .tabItem {
                            Image ( "pray" )
                            Text ( "Prayer" )
                        }
                        .tag ( 1 )
                    Settings ( )
                        .tabItem {
                            Label ( "Settings", systemImage: "gear" )
                        }
                        .tag ( 2 )
                }
                    .disabled ( self.ordo.GetLoading ( ) || self.prayers.GetLoading ( ) )
                    .TabBarGradient ( from: .blue.opacity ( 0.3 ), to: .green.opacity ( 0.5 ) )
            }
        }
            .environmentObject ( self.net )
            .environmentObject ( self.ordo )
            .environmentObject ( self.prayers )
            .task {
                await self.prayers.Update ( )
                await self.ordo.Update ( )
            }
            .onReceive ( NotificationCenter.default.publisher ( for: UIApplication.didBecomeActiveNotification ) ) { _ in
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
            .alert ( "A New Version of this Application is Available", isPresented: .constant ( !self.data_stale_alert_shown && self.net.connected && config.UpdateAvailable ( ).wrappedValue ) ) {
                Button ( "Update" ) {
                    if let url = URL ( string: self.app_url ), UIApplication.shared.canOpenURL ( url ) {
                        data_stale_alert_shown = true
                        UIApplication.shared.open ( url )
                    }
                }
                Button ( "Dismiss", role: .cancel, action: { } )
            }
    }
}
