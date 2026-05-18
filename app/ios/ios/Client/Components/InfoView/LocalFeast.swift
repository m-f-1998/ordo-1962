//
//  LocalFeast.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 28/01/2024.
//

import SwiftUI

struct LocalFeast: View {
    var data: LocaleData

    var body: some View {
        VStack {
            HStack ( spacing: 10 ) {
                VStack {
                    Text ( data.date )
                        .bold ( )
                        .padding ( )
                        .multilineTextAlignment ( .center )
                        .lineLimit ( nil )
                }
                .frame ( maxWidth: 120, maxHeight: .infinity )
                .background ( LiturgicalTheme ( colors: "w" ).accentSubtle )
                .clipShape ( RoundedRectangle ( cornerRadius: 8 ) )
                VStack ( alignment: .leading ) {
                    Text ( data.title )
                        .frame ( alignment: .leading )
                        .font ( .system ( size: 14.0, weight: .semibold, design: .serif ) )
                }
            }
        }
        .padding ( [ .vertical ], 8 )
    }
}

