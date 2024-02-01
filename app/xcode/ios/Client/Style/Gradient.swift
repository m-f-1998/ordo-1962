//
//  TabBarGradient.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 08/08/2023.
//

import SwiftUI

struct Gradient: ViewModifier {
    init ( from: UIColor, to: UIColor ) {
        let navbar = UINavigationBarAppearance ( )

        navbar.backgroundColor = .clear

        let imageRenderer = UIGraphicsImageRenderer ( size: .init ( width: 1, height: 1 ) )
        let gradientImage : UIImage = imageRenderer.image { ctx in
            let gradientLayer = CAGradientLayer ( )
            gradientLayer.frame = imageRenderer.format.bounds
            gradientLayer.colors = [ from.cgColor, to.cgColor ]
            gradientLayer.locations = [ 0, 1 ]
            gradientLayer.startPoint = .init ( x: 0.0, y: 0.0 )
            gradientLayer.endPoint = .init ( x: 0.5, y: 1.0 )
            gradientLayer.render ( in: ctx.cgContext )
        }
        navbar.backgroundImage = gradientImage

        UINavigationBar.appearance ( ).standardAppearance = navbar
        UINavigationBar.appearance ( ).compactAppearance = navbar
        UINavigationBar.appearance ( ).scrollEdgeAppearance = navbar
        if #available(iOS 15.0, *) {
            UINavigationBar.appearance ( ).compactScrollEdgeAppearance = navbar
        }
    }
    
    func body ( content: Content ) -> some View {
        content
    }

}

extension View {
    func SetGradient ( from: Color, to: Color ) -> some View {
        modifier ( Gradient ( from: UIColor ( from ), to: UIColor ( to ) ) )
    }
}
