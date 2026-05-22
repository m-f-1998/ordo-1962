//
//  LiturgicalTheme.swift
//  ordo-1962
//

import SwiftUI

/// Derives a semantic accent colour from a liturgical colour string.
/// Colour codes used in the data:
///   r = red, w = white, y = gold, g = green, v = violet/purple, b = black, p = pink/rose
struct LiturgicalTheme {
    let accent: Color
    let accentSubtle: Color

    init ( colors: String ) {
        let primary = colors.components ( separatedBy: "," ).first ?? "g"
        switch primary {
        case "r":
            accent = Color ( red: 0.72, green: 0.10, blue: 0.10 )   // deep crimson
        case "w":
            // White vestments — adaptive so it reads in both light and dark mode
            accent = Color ( UIColor { traits in
                traits.userInterfaceStyle == .dark
                    ? UIColor ( red: 0.88, green: 0.88, blue: 0.90, alpha: 1 )   // bright silver-white
                    : UIColor ( red: 0.38, green: 0.38, blue: 0.42, alpha: 1 )   // pewter
            } )
        case "y":
            accent = Color ( red: 0.72, green: 0.56, blue: 0.16 )   // gold
        case "g":
            accent = Color ( red: 0.13, green: 0.42, blue: 0.22 )   // forest green
        case "v":
            accent = Color ( red: 0.42, green: 0.20, blue: 0.55 )   // deep violet
        case "b":
            accent = Color ( red: 0.15, green: 0.15, blue: 0.15 )   // near-black
        case "p":
            accent = Color ( red: 0.78, green: 0.36, blue: 0.60 )   // rose
        default:
            accent = Color ( red: 0.13, green: 0.42, blue: 0.22 )   // fallback: green
        }
        accentSubtle = accent.opacity ( 0.12 )
    }

    /// Convenience initialiser from a `SeasonData` object.
    init ( season: SeasonData ) {
        self.init ( colors: season.colors )
    }

    /// Convenience initialiser from today's `OrdoDay`.
    /// The primary celebration's colour takes precedence over the season colour,
    /// so e.g. Christmas Day (celebration: w) overrides a green season.
    init ( day: OrdoDay ) {
        let celebrationColors = day.celebrations.first?.colors ?? ""
        if !celebrationColors.isEmpty {
            self.init ( colors: celebrationColors )
        } else {
            self.init ( season: day.season )
        }
    }
}
