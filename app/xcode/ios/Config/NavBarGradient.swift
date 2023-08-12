//
//  NavBarGradient.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/07/2023.
//

import SwiftUI

// Set Background Color of NavBar to a LinearGradient
struct NavGradient: ViewModifier {
    init ( from: UIColor, to: UIColor ) {
        let appearance = UINavigationBarAppearance ( )
        appearance.backgroundColor = .clear
        
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
        appearance.backgroundImage = gradientImage
        
        UINavigationBar.appearance ( ).standardAppearance = appearance
        UINavigationBar.appearance ( ).compactAppearance = appearance
        UINavigationBar.appearance ( ).scrollEdgeAppearance = appearance
    }
    
    func body ( content: Content ) -> some View {
        content
    }

}

extension View {
    func NavBarGradient ( from: Color, to: Color ) -> some View {
        modifier ( NavGradient ( from: UIColor ( from ), to: UIColor ( to ) ) )
    }
}
