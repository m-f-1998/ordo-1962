//
//  Row.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import SwiftUI

struct Row: View {
    let feast: OrdoDay
    let year: String
    @State private var menu_expanded: Bool = false
    
    var body: some View {
        HStack ( spacing: 10 ) {
            DisplayDate ( date: feast.date )
            VStack ( alignment: .leading ) {
                Feast ( data: self.feast.celebrations )
                HStack ( spacing: 5 ) {
                    Tag (
                        title: self.feast.season.title,
                        colors: self.feast.season.colors.components ( separatedBy: "," ).map {
                            Color ( word: $0 )!
                        }
                    )
                }.padding ( [ .top ], 5 )
                if !self.feast.fasting.isEmpty {
                    HStack ( spacing: 5 ) {
                        ForEach ( self.feast.fasting, id: \.self ) { fast in
                            Tag (
                                title: fast,
                                colors: [ Color ( word: "v" )! ]
                            )
                        }
                    }.padding ( [ .top ], 5 )
                }
            }
        }
    }
}

struct FeastInfo: View {
    var title, colors: String
    var title_size: Double
    @Environment ( \.colorScheme ) var colorScheme

    var body: some View {
        HStack {
            Text ( self.title )
                .frame ( alignment: .leading )
                .font ( .system ( size: self.title_size ) )
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
    var data: [ CelebrationData ]

    var body: some View {
        VStack ( alignment: .leading, spacing: 10 ) {
            ForEach ( self.data, id: \.id ) { feast in
                if self.data.count > 1 && feast.title != data [ 0 ].title {
                    Divider ( )
                }
                FeastInfo ( title: feast.title, colors: feast.colors, title_size: 16.0 )
                ForEach ( feast.commemorations, id: \.self ) {
                    FeastInfo ( title: $0.title, colors: $0.colors, title_size: 13.0 )
                }
                Text ( "Class \(feast.rank)" )
                    .padding ( [ .top ], 1 )
                    .font ( .system ( size: 12 ) )
                if feast.options != "" {
                    Text ( feast.options )
                        .padding ( [ .top ], 0.5 )
                        .font ( .system ( size: 12 ) )
                }
            }
        }
    }
}
