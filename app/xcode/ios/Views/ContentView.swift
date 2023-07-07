//
//  ContentView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 12/03/2023.
//

import SwiftUI

struct ContentView: View {
    private let app_url = "itms-apps://itunes.apple.com/app/6450934181"
    private let config: FirebaseConfig = FirebaseConfig ( )

    @ObservedObject var net: NetworkMonitor = NetworkMonitor ( )
    @ObservedObject var ordo: OrdoAPI = OrdoAPI ( )
    @ObservedObject var prayers: PrayerAPI = PrayerAPI ( )

    init ( ) {
        UserDefaults.standard.set ( CurrentYear ( ), forKey: "year" )
        if UserDefaults.standard.string ( forKey: "lang" ) == nil {
            UserDefaults.standard.set ( "English", forKey: "lang" )
        }
    }

    var body: some View {
        VStack ( spacing: 0 ) {
            switch ordo.res {
            case .failure ( let error ):
                ErrorView ( description: error )
            case .loading ( let data ), .success ( let data ):
                Ordo ( data: data )
            }
            if ( !self.net.connected ) {
                VStack ( alignment: .center ) {
                    Text ( "No Internet Connection" )
                        .bold ( )
                        .foregroundColor ( .white )
                        .frame ( maxWidth: .infinity )
                        .padding ( [ .top ], 10 )
                }
                    .background ( .red )
            }
        }
            .environmentObject ( ordo )
            .environmentObject ( prayers )
            .task {
                await ordo.Update ( )
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
