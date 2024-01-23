//
//  LoadingView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 07/12/2023.
//

import SwiftUI

struct LoadingView: View {
    @EnvironmentObject var activeData: ActiveData

    var body: some View {
        NavigationStack {
            ZStack {
                PlaceholderList ( )
                VStack ( spacing: 10 ) {
                    ProgressView ( )
                        .progressViewStyle ( .circular )
                    if self.activeData.downloading {
                        Text ( "Downloading Update (" + String ( self.activeData.percentage ) + "%)..." )
                    } else {
                        Text ( "Loading..." )
                    }
                }
                    .padding ( )
                    .tint ( .white )
                    .foregroundStyle ( .white )
                    .background ( .black )
                    .cornerRadius ( 10 )
            }
                .navigationTitle ( "1962 Liturgical Ordo" )
        }
            .SetGradient ( from: .blue.opacity ( 0.3 ), to: .green.opacity ( 0.5 ) )
    }
}
