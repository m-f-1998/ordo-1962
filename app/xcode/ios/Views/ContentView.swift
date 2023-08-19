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
    @ObservedObject var propers: PropersAPI = PropersAPI ( )
    
    @State var search_text: String = ""
    @State private var tab_selection: Int = 0
    @State private var data_stale_alert_shown: Bool = false

    init ( ) {
        UserDefaults.standard.set ( CurrentYear ( ), forKey: "year" )
        
        if UserDefaults.standard.string ( forKey: "prayers-lang" ) == nil {
            UserDefaults.standard.set ( "English", forKey: "prayers-lang" )
        }
        
        if UserDefaults.standard.string ( forKey: "propers-lang" ) == nil {
            UserDefaults.standard.set ( "English", forKey: "propers-lang" )
        }
    }
    
    func reload ( ) {
        self.prayers.ErrorRetry ( )
        self.propers.ErrorRetry ( )
        self.ordo.ErrorRetry ( )
    }

    var body: some View {
        VStack ( spacing: 0 ) {
            switch ordo.res { // MARK: Future Update, All Errors Should Be Handled Here
            case .failure ( let error ):
                ErrorView ( description: error, Callback: self.reload )
            case .success ( _ ), .loading ( _ ):
                let data = ordo.GetResult ( search: self.search_text )
                TabView ( selection: $tab_selection ) {
                    Ordo ( search_text: self.$search_text, selected_tab: self.$tab_selection, data: data )
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
                    Settings ( selected_tab: $tab_selection )
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
            .environmentObject ( self.propers )
            .task {
                DispatchQueue.main.async {
                    Task {
                        await self.prayers.Update ( )
                        await self.propers.Update ( )
                        await self.ordo.Update ( )
                    }
                }
            }
            .onChange ( of: self.net.connected ) { change in
                if !change && UserDefaults.standard.string ( forKey: "year" )! != CurrentYear ( ) {
                    self.ordo.BackToCurrentYear ( )
                    self.propers.BackToCurrentYear ( )
                    self.tab_selection = 0
                }
            }
            .onReceive ( NotificationCenter.default.publisher ( for: UIApplication.didBecomeActiveNotification ) ) { _ in
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
            .alert ( "A New Version of this Application is Available", isPresented: .constant ( !self.data_stale_alert_shown && config.UpdateAvailable ( ).wrappedValue ) ) {
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
