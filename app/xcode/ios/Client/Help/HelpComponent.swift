//
//  DisplayInfo.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 29/12/2023.
//


import SwiftUI

struct HelpComponent: View {
    var body: some View {
        NavigationStack {
            List {
                Section ( header: Text ( "Notes on the Calendar" ) ) {
                    ForEach ( calendar_info.sorted ( by: > ), id: \.key ) { key, value in
                        NavigationLink ( destination:
                            DisplayText ( text: value ).navigationTitle ( key )
                        ) {
                            Text ( key )
                        }
                    }
                }
                
                Section ( header: Text ( "Votive Mass Propers" ) ) {
                    ForEach ( votive_propers.keys, id: \.self ) { key in
                        NavigationLink ( destination:
                            DisplayPropers ( celebrations: [ votive_propers [ key ]! ] )
                        ) {
                            Text ( key )
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode ( .inline )
        }
    }
}

