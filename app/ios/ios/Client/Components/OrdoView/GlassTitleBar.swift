//
//  GlassTitleBar.swift
//  ordo-1962
//

import SwiftUI

struct GlassTitleBar: View {
    let accent: Color

    var body: some View {
        HStack ( spacing: 10 ) {
            Image ( "christian-cross" )
                .resizable ( )
                .renderingMode ( .template )
                .scaledToFit ( )
                .frame ( width: 14, height: 17 )
                .foregroundStyle ( accent )

            Text ( "1962 Liturgical Ordo" )
                .font ( .system ( size: 17, weight: .semibold, design: .serif ) )
                .foregroundStyle ( .primary )
        }
        .padding ( .horizontal, 16 )
        .padding ( .vertical, 8 )
        .background ( .regularMaterial, in: Capsule ( ) )
        .overlay (
            Capsule ( )
                .stroke (
                    LinearGradient (
                        colors: [
                            accent.opacity ( 0.45 ),
                            accent.opacity ( 0.10 )
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        )
        .shadow ( color: accent.opacity ( 0.18 ), radius: 8, y: 2 )
    }
}
