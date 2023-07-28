//
//  SelectYear.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 27/05/2023.
//

import SwiftUI

// Settings Specifically For The Calendar e.g. Language; Year etc.
struct Options: View {
    @EnvironmentObject var ordo: OrdoAPI
    @EnvironmentObject var propers: PropersAPI
    @EnvironmentObject var net: NetworkMonitor
    
    @State private var locale: String = "General"
    @State private var year: String = UserDefaults.standard.string ( forKey: "year" )!
    @Binding var settings_open: Bool

    let proxy: ScrollViewProxy
    private let years: [ String ] = ( Int ( CurrentYear ( ) )!...Int ( CurrentYear ( ) )! + 10 ).map { "\($0)" }
    private let locations: [ String ] = [
        "General"
    ]

    var body: some View {
        if ( self.net.connected ) {
            Section {
                CustomPicker ( data: self.years, title: "Year", selected: self.$year )
                    .onChange ( of: year ) { change in
                        UserDefaults.standard.set ( change, forKey: "year" )
                        if change != CurrentYear ( ) {
                            proxy.scrollTo ( "January", anchor: .top )
                        } else {
                            if let id = self.ordo.GetIDToday ( ) {
                                proxy.scrollTo ( id, anchor: .top )
                            }
                        }
                        
                        ordo.SetLoading ( )
                        self.settings_open = false

                        Task {
                            await propers.Update ( ignore_cache: true )
                            await ordo.Update ( ignore_cache: true )
                        }
                    }
                CustomPicker ( data: self.locations, title: "Calendar", selected: self.$locale )
            } header: {
                Text ( "App Options" )
            } footer: {
                Text ( "Localization Options Coming Soon" )
            }
        }
    }
}
