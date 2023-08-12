//
//  TabBarGradient.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 08/08/2023.
//

import SwiftUI

// Set Tab Bar (Bottom) To Linear Gradient
struct TabGradient: ViewModifier {
    init ( from: UIColor, to: UIColor ) {
        let appearance = UITabBarAppearance ( )
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
        
        UITabBar.appearance ( ).standardAppearance = appearance
        UITabBar.appearance ( ).scrollEdgeAppearance = appearance
    }
    
    func body ( content: Content ) -> some View {
        content
    }

}

extension View {
    func TabBarGradient ( from: Color, to: Color ) -> some View {
        modifier ( TabGradient ( from: UIColor ( from ), to: UIColor ( to ) ) )
    }
}
