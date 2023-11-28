//
//  Extensions.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 24/06/2023.
//

import SwiftUI

// Format Date In Given Format
func FormatDate ( time: Bool = false, short: Bool = false ) -> DateFormatter {
    let formatter = DateFormatter ( )
    if short {
        formatter.dateFormat = "E dd MMMM yyyy"
    } else if time {
        formatter.dateFormat = "E dd MMM yyyy HH:mm"
    } else {
        formatter.dateFormat = "E dd MMM yyyy"
    }
    return formatter
}

// Current Month - Full Name
func CurrentMonth ( ) -> String {
    let today = Calendar.current.dateComponents ( [ .month ], from: .now )
    return Calendar.current.monthSymbols [ today.month! - 1 ]
}

// Current Day In Int (Array Index Is -1)
func CurrentDay ( add: Int = 0 ) -> Int {
    var dateComponent = DateComponents()
    dateComponent.day = add
    let today = Calendar.current.date ( byAdding: dateComponent, to: .now )
    return Calendar.current.component ( .day, from: today! )
}

// Current Year As A String
func CurrentYear ( ) -> Int {
    return Calendar.current.component ( .year, from: .now )
}

// Ordo Data For When List Loading
let DUMMY_ORDO: OrdoMonth = Calendar.current.monthSymbols.reduce ( into: OrdoMonth () ) { // Displayed in redacted format when loading
    $0 [ $1 ] = [
        CelebrationData.init (
            date: FormatDate ( ).string ( from: .distantPast ),
            celebrations: [
                FeastData.init ( title: "Dummy Title", rank: 1, colors: "g", options: "Dummy Options", propers: nil, commemorations: [] )
            ],
            season: SeasonData ( title: "Dummy Season", colors: "g" )
        )
    ]
}

// Colours by Tags
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
            self = .purple
        case "p":
            self = Color ( red: 2.55, green: 0, blue: 1.27 )
        default:
            self = .white
        }
    }
}

// Color Blends
extension LinearGradient {
    init? ( colors: [ Color ] = [ .green.opacity ( 0.3 ), .blue.opacity ( 0.5 ) ] ) {
        self = LinearGradient ( colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing )
    }
}
