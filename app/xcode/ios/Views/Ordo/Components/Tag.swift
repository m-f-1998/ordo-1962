//
//  TagView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI

struct Tag: View {
    var title: String
    var colors: [ Color ]

    var body: some View {
        Text ( self.title )
            .font ( .system ( size: 12 ) )
            .bold ( )
            .padding ( 5 )
            .background ( LinearGradient ( colors: self.colors ) )
            .cornerRadius ( 7 )
            .overlay (
                RoundedRectangle ( cornerRadius: 7 )
                    .stroke ( .black, lineWidth: 1 )
                    .padding ( [ .top, .bottom ], 0.5 )
            )
    }
}
