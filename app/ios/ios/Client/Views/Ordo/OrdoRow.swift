//
//  Row.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import SwiftUI

struct OrdoRow: View {
    let feast: OrdoDay
    let year: String

    private var theme: LiturgicalTheme {
        LiturgicalTheme ( day: feast )
    }

    var body: some View {
        HStack ( spacing: 0 ) {
            Rectangle ( )
                .fill ( theme.accent )
                .frame ( width: 4 )
                .clipShape ( RoundedRectangle ( cornerRadius: 2 ) )
                .padding ( .trailing, 10 )

            DisplayDate ( date: feast.date )
                .padding ( .trailing, 10 )

            VStack ( alignment: .leading, spacing: 4 ) {
                OrdoFeast ( data: self.feast.celebrations, theme: theme )
                HStack ( spacing: 5 ) {
                    Tag (
                        title: self.feast.season.title,
                        accent: theme.accent
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
