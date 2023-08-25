//
//  SelectYear.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 27/05/2023.
//

import SwiftUI

// Settings Specifically For The Calendar e.g. Language; Year etc.
struct Options: View {
    @State private var locale: String = "General"
    private let locations: [ String ] = [
        "General"
    ]

    var body: some View {
        Section {
            CustomPicker ( data: self.locations, title: "Calendar", selected: self.$locale )
        } header: {
            Text ( "App Options" )
        } footer: {
            Text ( "Localization Options Coming Soon" )
        }
    }
}
