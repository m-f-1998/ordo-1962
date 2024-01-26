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
                Section ( header: Text ( "User Information" ) ) {
                    ForEach ( calendar_details.sorted ( by: < ), id: \.key ) { key, value in
                        NavigationLink {
                            DisplayText ( text: value ).navigationTitle ( key )
                        } label: {
                            Text ( key )
                        }
                    }
                }
                Section ( "Additional Mass Propers" ) {
                    NavigationLink {
                        AdditionalMassPropers ( )
                    } label: {
                        Text ( "Votive Masses" )
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode ( .inline )
    }
}

struct AdditionalMassPropers: View {
    @Environment ( \.colorScheme ) var colorScheme

    var body: some View {
        List {
            ForEach ( InfoStructure, id: \.self ) { info in
                Section ( header: Text ( info.header ), footer: Text ( info.footer ) ) {
                    ForEach ( info.data.keys, id: \.self ) { key in
                        NavigationLink {
                            DisplayPropers ( celebrations: [ info.data [ key ]! ] )
                        } label: {
                            HStack {
                                Text ( key )
                                Circle ( )
                                    .strokeBorder ( colorScheme == .dark ? .white : .black, lineWidth: 1 )
                                    .background (
                                        Circle ( )
                                            .foregroundColor ( Color ( word: info.data [ key ]!.colors.components ( separatedBy: "," ) [ 0 ] ) )
                                    )
                                    .frame ( width: 15, height: 15 )
                            }
                        }
                    }
                }
            }
        }.listRowSpacing(0)
    }
}
