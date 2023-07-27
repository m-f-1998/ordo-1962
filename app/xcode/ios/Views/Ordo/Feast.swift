//
//  Feast.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI

private struct FeastInfo: View {
    var title, colors: String
    var title_size: Double
    @Environment ( \.colorScheme ) var colorScheme

    var body: some View {
        HStack {
            Text ( self.title )
                .frame ( alignment: .leading )
                .scaledFont ( size: self.title_size )
                .bold ( )
            Circle ( )
                .strokeBorder ( colorScheme == .dark ? .white : .black, lineWidth: 1 )
                .background (
                    Circle ( )
                        .foregroundColor ( Color ( word: self.colors.components ( separatedBy: "," ) [ 0 ] ) )
                )
                .frame ( width: 15, height: 15 )
        }
    }
}

struct Feast: View {
    var data: [ FeastData ]

    var body: some View {
        ForEach ( self.data, id: \.self ) { feast in
            VStack ( alignment: .leading ) {
                FeastInfo ( title: feast.title, colors: feast.colors, title_size: 18.0 )
                if feast.commemorations != nil {
                    ForEach ( feast.commemorations!, id: \.self ) {
                        FeastInfo ( title: $0.title + " (Commem)", colors: $0.colors, title_size: 14.0 )
                    }
                }
                VStack ( alignment: .leading ) {
                    Text ( "Class \(feast.rank)" )
                        .padding ( [ .top ], 2 )
                    if let options = feast.options {
                        Text ( options )
                            .padding ( [ .top ], 1 )
                    }
                }
                    .scaledFont ( size: 12 )
                    .frame ( maxWidth: .infinity, alignment: .leading )
            }
        }
    }
}
