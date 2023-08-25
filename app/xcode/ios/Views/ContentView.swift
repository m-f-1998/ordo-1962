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
    
    @State var search_text: String = ""
    @State private var tab_selection: Int = 0
    @State private var data_stale_alert_shown: Bool = false
    
    @State private var tappedTwice: Bool = false
    var handler: Binding<Int> { Binding (
        get: { self.tab_selection },
        set: {
            if $0 == self.tab_selection {
                self.tappedTwice = true
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
            switch ordo.res { // TODO: Future Update, All Errors Should Be Handled Here
            case .failure ( let error ):
                ErrorView ( description: error, Callback: self.reload )
            case .success ( _ ), .loading ( _ ):
                let data = ordo.GetResult ( search: self.search_text )
                TabView ( selection: handler ) {
                    Ordo ( search_text: self.$search_text, selected_tab: self.$tab_selection, data: data, tappedTwice: self.$tappedTwice  )
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
                    .disabled ( data == DUMMY_ORDO )
                    .TabBarGradient ( from: .blue.opacity ( 0.3 ), to: .green.opacity ( 0.5 ) )
            case .none:
                ErrorView ( description: "Data Status Unknown", Callback: self.reload )
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
