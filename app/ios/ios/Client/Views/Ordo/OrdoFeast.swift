//
//  OrdoFeast.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 23/01/2024.
//

import SwiftUI

struct FeastInfo: View {
    var title: String
    var title_size: Double
    var isPrimary: Bool = false

    var body: some View {
        Text ( self.title )
            .frame ( alignment: .leading )
            .font ( .system ( size: self.title_size, weight: isPrimary ? .semibold : .regular, design: .serif ) )
    }
}

struct OrdoFeast: View {
    var data: [ CelebrationData ]
    var theme: LiturgicalTheme

    var body: some View {
        VStack ( alignment: .leading, spacing: 8 ) {
            ForEach ( self.data, id: \.id ) { feast in
                if self.data.count > 1 && feast.title != data [ 0 ].title {
                    Divider ( )
                }
                FeastInfo ( title: feast.title, title_size: 15.0, isPrimary: true )
                ForEach ( feast.commemorations, id: \.self ) {
                    FeastInfo ( title: $0.title, title_size: 13.0 )
                }
                Text ( "Class \(feast.rank)" )
                    .font ( .system ( size: 11 ) )
                    .foregroundStyle ( .secondary )
                if feast.options != "" {
                    Text ( feast.options )
                        .font ( .system ( size: 11 ) )
                        .foregroundStyle ( .secondary )
                }
            }
        }
    }
}
