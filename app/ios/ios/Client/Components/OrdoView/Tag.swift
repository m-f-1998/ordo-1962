//
//  TagView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI

struct Tag: View {
    let title: String
    let accent: Color

    var body: some View {
        Text ( self.title )
            .font ( .system ( size: 11, weight: .semibold ) )
            .padding ( .horizontal, 8 )
            .padding ( .vertical, 4 )
            .background ( accent.opacity ( 0.12 ) )
            .foregroundStyle ( accent )
            .clipShape ( Capsule ( ) )
            .multilineTextAlignment ( .center )
            .lineLimit ( 2 )
    }
}
