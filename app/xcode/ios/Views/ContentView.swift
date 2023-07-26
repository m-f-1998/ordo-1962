//
//  ContentView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 12/03/2023.
//

import SwiftUI

struct ContentView: View {
    private let app_url: String = "itms-apps://itunes.apple.com/app/6450934181"
    private let config: FirebaseConfig = FirebaseConfig ( )

    @ObservedObject var net: NetworkMonitor = NetworkMonitor ( )
    @ObservedObject var ordo: OrdoAPI
    @ObservedObject var prayers: PrayerAPI
    @ObservedObject var propers: PropersAPI
    
    @State var search_text: String = ""

    init ( ) {
        self.ordo = OrdoAPI ( config: self.config )
        self.prayers = PrayerAPI ( config: self.config )
        self.propers = PropersAPI ( config: self.config )
        
        UserDefaults.standard.set ( CurrentYear ( ), forKey: "year" )
        if UserDefaults.standard.string ( forKey: "prayers-lang" ) == nil {
            UserDefaults.standard.set ( "English", forKey: "prayers-lang" )
        }

    }

    var body: some View {
        VStack ( spacing: 0 ) {
            switch ordo.res {
            case .failure ( let error ):
                ErrorView ( description: error )
            case .loading ( _ ), .success ( _ ):
                Ordo ( search_text: self.$search_text, data: ordo.GetResult ( search: self.search_text ) )
                if ( !self.net.connected ) {
                    VStack ( alignment: .center ) {
                        Text ( "No Internet Connection" )
                            .bold ( )
                            .foregroundColor ( .white )
                            .frame ( maxWidth: .infinity )
                            .padding ( [ .top, .bottom ], 10 )
                    }
                        .background ( .red )
                }
            }
        }
            .environmentObject ( self.net )
            .environmentObject ( self.ordo )
            .environmentObject ( self.prayers )
            .environmentObject ( self.propers )
            .task {
                await self.ordo.Update ( )
            }
            .onChange ( of: self.net.connected ) { change in
                Task {
                    if ( !change && UserDefaults.standard.string ( forKey: "year" )! != CurrentYear ( ) ) {
                        await self.ordo.BackToCurrentYear ( )
                    }
                }
            }
            .onReceive ( NotificationCenter.default.publisher ( for: UIApplication.didBecomeActiveNotification ) ) { _ in
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
            .alert ( "A New Version of this Application is Available", isPresented: self.config.UpdateAvailable ( ) ) {
                Button ( "Update" ) {
                    if let url = URL ( string: self.app_url ), UIApplication.shared.canOpenURL ( url ) {
                        UIApplication.shared.open ( url )
                    }
                }
            }
    }
}
