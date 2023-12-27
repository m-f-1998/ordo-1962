//
//  LoadingView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 07/12/2023.
//

import SwiftUI

struct LoadingView: View {
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
                LoadingIndicator ( )
            }
                .navigationTitle ( "Liturgical Ordo" )
        }
            .SetGradient ( from: .blue.opacity ( 0.3 ), to: .green.opacity ( 0.5 ) )
    }
}

struct LoadingIndicator: View {
    @EnvironmentObject var activeData: ActiveData

    var body: some View {
        VStack ( spacing: 10 ) {
            ProgressView ( )
                .progressViewStyle ( .circular )
            if self.activeData.downloading {
                Text ( "Downloading Update..." )
            } else {
                Text ( "Loading..." )
            }
        }
            .padding ( )
            .tint ( .white )
            .background ( .black )
            .cornerRadius ( 10 )
    }
}
