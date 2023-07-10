//
//  SelectYear.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 27/05/2023.
//

import SwiftUI

struct Options: View {
    var data: [ String ]
    var title: String
    @Binding var selected: String

    var body: some View {
        Picker ( title, selection: $selected ) {
            ForEach ( self.data, id: \.self ) {
                Text ( $0 )
            }
        }
    }
    
}

struct OrdoOptions: View {
    @EnvironmentObject var ordo: OrdoAPI

    @ObservedObject var net: NetworkMonitor = NetworkMonitor ( )
    @Binding var settings_open: Bool
    let proxy: ScrollViewProxy

    var years: [ String ] = ( Int ( CurrentYear ( ) )!...Int ( CurrentYear ( ) )! + 10 ).map { "\($0)" }
    @State var year: String = UserDefaults.standard.string ( forKey: "year" )!

    var locations: [ String ] = [ "General" ]
    @State var locale: String = "General"

    var body: some View {
        Section {
            if ( self.net.connected ) {
                Options ( data: self.years, title: "Year", selected: self.$year )
                    .onChange ( of: year ) { change in
                        UserDefaults.standard.set ( change, forKey: "year" )
                        Task {
                            if change != CurrentYear ( ) {
                                proxy.scrollTo ( "January", anchor: .top )
                            }
                            ordo.SetLoading ( )
                            self.settings_open = false
                            await ordo.Update ( ignore_cache: true )
                        }
                    }
                Options ( data: self.locations, title: "Calendar", selected: self.$locale )
            }
        } header: {
            Text ( "App Options" )
        } footer: {
            Text ( "Localization Options Coming Soon" )
        }
    }
}
