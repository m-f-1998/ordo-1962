//
//  TagView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI

struct Tag: View { // A capsule shape, used as a tag element on screen
    var title: String
    var colors: [ Color ]

    var body: some View {
        Text ( self.title )
            .font ( .system ( size: 12 ) )
            .padding ( 6 )
            .bold ( )
            .background ( LinearGradient ( colors: self.colors ) )
            .clipShape ( Capsule ( ) )
            .overlay ( Capsule ( )
                .stroke ( lineWidth: 1 )
                .foregroundColor ( .black )
            )
    }
}
