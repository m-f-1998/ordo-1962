//
//  ScalableFont.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import SwiftUI

// Adjust Font Based On Device Size
@available ( iOS 13, macCatalyst 13, tvOS 13, watchOS 6, * )
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var size: CGFloat

    func body ( content: Content ) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue ( for: self.size )
        return content.font ( .system ( size: scaledSize ) )
    }
}

@available ( iOS 13, macCatalyst 13, tvOS 13, watchOS 6, * )
extension View {
    func scaledFont ( size: CGFloat ) -> some View {
        return self.modifier ( ScaledFont ( size: size ) )
    }
}
