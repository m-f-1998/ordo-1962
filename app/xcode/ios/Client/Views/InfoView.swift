//
//  DisplayInfo.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 29/12/2023.
//


import SwiftUI

struct InfoView: View {
    var body: some View {
        NavigationStack {
            List {
                Section ( header: Text ( "Notes on the Calendar" ) ) {
                    ForEach ( calendar_details.sorted ( by: > ), id: \.key ) { key, value in
                        NavigationLink {
                            DisplayText ( text: value ).navigationTitle ( key )
                        } label: {
                            Text ( key )
                        }
                    }
                }
                ForEach ( InfoStructure, id: \.self ) { info in
                    Section ( header: Text ( info.header ), footer: Text ( info.footer ) ) {
                        ForEach ( info.data.keys, id: \.self ) { key in
                            NavigationLink {
                                DisplayPropers ( celebrations: [ info.data [ key ]! ] )
                            } label: {
                                Text ( key )
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode ( .inline )
    }
}

