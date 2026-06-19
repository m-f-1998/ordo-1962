//
//  Row.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import SwiftUI

struct OrdoRow: View {
    @Environment(\.colorScheme) var colorScheme
    let feast: OrdoDay
    let year: String

    private var theme: LiturgicalTheme {
        LiturgicalTheme ( day: feast )
    }

    var body: some View {
        let isLightModeWhite = (colorScheme == .light && theme.isWhite)

        HStack ( spacing: 0 ) {
            Rectangle ( )
                .fill ( theme.accent )
                .frame ( width: 4 )
                .clipShape ( RoundedRectangle ( cornerRadius: 2 ) )
                .overlay (
                    RoundedRectangle ( cornerRadius: 2 )
                        .stroke ( Color.secondary.opacity ( 0.4 ), lineWidth: isLightModeWhite ? 0.5 : 0 )
                )
                .padding ( .trailing, 10 )

            DisplayDate ( date: feast.date )
                .padding ( .trailing, 10 )

            VStack ( alignment: .leading, spacing: 4 ) {
                OrdoFeast ( data: self.feast.celebrations, theme: theme )
                HStack ( spacing: 5 ) {
                    Tag (
                        title: self.feast.season.title,
                        accent: theme.accent,
                        isWhite: theme.isWhite
                    )
                    ForEach ( self.feast.fasting, id: \.self ) { fast in
                        Tag (
                            title: fast,
                            accent: LiturgicalTheme ( colors: "v" ).accent
                        )
                    }
                }.padding ( [ .top ], 4 )
            }
        }
        .padding ( .vertical, 4 )
    }
}
