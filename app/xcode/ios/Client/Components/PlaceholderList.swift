//
//  PlaceholderView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 21/01/2024.
//

import SwiftUI

struct PlaceholderList: View {
    var body: some View {
        List ( Calendar.current.shortMonthSymbols, id: \.self ) { month in
            Section ( header: Spacer ( minLength: 0 ) ) {
                HStack ( spacing: 10 ) {
                    DisplayDate ( date: DateInfo ( ) )
                    VStack ( alignment: .leading ) {
                        OrdoFeast ( data: [ CelebrationData ( ) ] )
                        Tag (
                            title: String ( repeating: "*", count: 10 ),
                            colors: [ .green.opacity ( 0.5 ) ]
                        )
                            .padding ( [ .trailing, .leading ], 2 )
                    }
                }
                    .padding ( [ .top, .bottom ], 8 )
            }
        }
            .redacted ( reason: .placeholder )
            .scrollDisabled ( true )
    }
}
