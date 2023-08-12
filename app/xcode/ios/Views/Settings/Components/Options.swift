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
    
    @State private var locale: String = "General"
    @State private var year: String = UserDefaults.standard.string ( forKey: "year" )!
    @Binding var selected_tab: Int

    private let years: [ String ] = ( Int ( CurrentYear ( ) )!...Int ( CurrentYear ( ) )! + 10 ).map { "\($0)" }
    private let locations: [ String ] = [
        "General"
    ]

    var body: some View {
        Section {
            CustomPicker ( data: self.years, title: "Year", selected: self.$year )
                .onChange ( of: self.year ) { change in
                    if ( change == CurrentYear ( ) ) {
                        UserDefaults.standard.set ( 3, forKey: "go-to-today" )
                        self.ordo.BackToCurrentYear ( )
                        self.propers.BackToCurrentYear ( )
                    } else {
                        UserDefaults.standard.set ( change, forKey: "year" )
                        self.ordo.SetLoading ( )
                        Task {
                            await self.propers.Update ( use_cache: change == CurrentYear ( ) )
                            await self.ordo.Update ( use_cache: change == CurrentYear ( )  )
                        }
                    }
                    
                    self.selected_tab = 0
                }
                .onAppear {
                    year = UserDefaults.standard.string ( forKey: "year" )!
                }
            CustomPicker ( data: self.locations, title: "Calendar", selected: self.$locale )
        } header: {
            Text ( "App Options" )
        } footer: {
            Text ( "Localization Options Coming Soon" )
        }
    }
}
