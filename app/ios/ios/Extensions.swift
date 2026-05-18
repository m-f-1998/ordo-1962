//
//  Extensions.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 24/06/2023.
//

import SwiftUI

extension Color {
    init? ( word: String ) {
        switch word {
        case "y":
            self = Color ( red: 0.9882352941, green: 0.7607843137, blue: 0 )
        case "b":
            self = .black
        case "w":
            self = .white
        case "r":
            self = .red
        case "o":
            self = .orange
        case "g":
            self = .green
        case "v":
            self = Color ( red: 191/255, green: 139/255, blue: 1 )
        case "p":
            self = Color ( red: 0.78, green: 0.36, blue: 0.60 )
        default:
            return nil
        }
    }
}
