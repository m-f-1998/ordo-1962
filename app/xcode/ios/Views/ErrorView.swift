//
//  Error.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 19/04/2023.
//

import SwiftUI

struct ErrorView: View {
    let description: String

    var body: some View {
        NavigationStack {
            ZStack {
                List ( Calendar.current.shortMonthSymbols, id: \.self ) { month in
                    Section {
                        HStack ( spacing: 10 ) {
                            DisplayDate ( day: "Mon", date: "1", month: month )
                            LazyVStack ( alignment: .leading ) {
                                Feast ( data: [ CelebrationData ( ) ] )
                                Tag (
                                    title: String ( repeating: "*", count: 10 ),
                                    colors: [ Color.green.opacity ( 0.5 ) ]
                                )
                                    .padding ( [ .trailing, .leading ], 2 )
                            }
                        }
                            .padding ( [ .top, .bottom ], 8 )
                    }
                }
                    .redacted ( reason: .placeholder )
                    .padding ( [ .top ], 20 )
                    .scrollDisabled ( true )
                VStack ( spacing: 10 ) {
                    Text ( description )
                }
                    .padding ( )
                    .tint ( .white )
                    .foregroundStyle ( .white )
                    .background ( .black )
                    .cornerRadius ( 10 )
            }
                .navigationTitle ( "Liturgical Calendar" )
        }
            .SetGradient ( from: .blue.opacity ( 0.3 ), to: .green.opacity ( 0.5 ) )
    }

}
