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
                HStack ( spacing: 0 ) {
                    Rectangle ( )
                        .fill ( Color.secondary.opacity ( 0.3 ) )
                        .frame ( width: 4 )
                        .clipShape ( RoundedRectangle ( cornerRadius: 2 ) )
                        .padding ( .trailing, 10 )
                    DisplayDate ( date: DateInfo ( ) )
                        .padding ( .trailing, 10 )
                    VStack ( alignment: .leading ) {
                        OrdoFeast ( data: [ CelebrationData ( ) ], theme: LiturgicalTheme ( colors: "g" ) )
                        Tag ( title: String ( repeating: "*", count: 10 ), accent: .secondary )
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
