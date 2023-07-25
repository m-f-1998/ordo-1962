//
//  FeastView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI

struct Feast: View { // Information row on the feast of the day
    var data: [ FeastData ]

    var body: some View {
        ForEach ( self.data, id: \.self ) { feast in
            VStack ( alignment: .leading ) {
                HStack {
                    Text ( feast.title )
                        .frame ( alignment: .leading )
                        .scaledFont ( size: 18.0 )
                        .bold ( )
                    Circle ( )
                        .strokeBorder ( .black, lineWidth: 1 )
                        .background (
                            Circle ( )
                                .foregroundColor ( Color ( word: feast.colors.components ( separatedBy: "," ) [ 0 ] ) )
                        )
                        .frame ( width: 15, height: 15 )
                }
                if feast.commemorations != nil {
                    ForEach ( feast.commemorations!, id: \.self ) { commemoration in
                        HStack {
                            Text ( commemoration.title + " (Commem)" )
                                .frame ( alignment: .leading )
                                .scaledFont ( size: 15.0 )
                                .bold ( )
                            Circle ( )
                                .strokeBorder ( .black, lineWidth: 1 )
                                .background (
                                    Circle ( )
                                        .foregroundColor ( Color ( word: commemoration.colors.components ( separatedBy: "," ) [ 0 ] ) )
                                )
                                .frame ( width: 15, height: 15 )
                        }
                    }
                }
                Text ( "Class \(feast.rank)" )
                    .scaledFont ( size: 12 )
                    .frame ( maxWidth: .infinity, alignment: .leading )
                    .padding ( [ .top ], 2 )
                if let options = feast.options {
                    Text ( options )
                        .scaledFont ( size: 12 )
                        .frame ( maxWidth: .infinity, alignment: .leading )
                        .padding ( [ .top ], 1 )
                }
            }
        }
    }
}
