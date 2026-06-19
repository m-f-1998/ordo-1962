//
//  TagView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI

struct Tag: View {
    @Environment(\.colorScheme) var colorScheme
    let title: String
    let accent: Color
    var isWhite: Bool = false

    var body: some View {
        let isLightModeWhite = (colorScheme == .light && isWhite)

        Text ( verbatim: self.title )
            .font ( .system ( size: 11, weight: .semibold ) )
            .padding ( .horizontal, 8 )
            .padding ( .vertical, 4 )
            .background ( isLightModeWhite ? Color.white : accent.opacity ( 0.12 ) )
            .foregroundStyle ( isLightModeWhite ? Color.primary : accent )
            .clipShape ( Capsule ( ) )
            .overlay (
                Capsule ( )
                    .stroke ( Color.secondary.opacity ( 0.4 ), lineWidth: isLightModeWhite ? 1 : 0 )
            )
            .multilineTextAlignment ( .center )
            .lineLimit ( 2 )
            .fixedSize ( horizontal: false, vertical: true )
            .layoutPriority ( 1 )
    }
}
