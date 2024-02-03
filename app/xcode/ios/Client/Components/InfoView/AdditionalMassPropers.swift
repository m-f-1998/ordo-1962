//
//  AdditionalMassPropers.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 28/01/2024.
//

import SwiftUI

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
        }.listRowSpacing ( 0 )
    }
}
