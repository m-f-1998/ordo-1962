//
//  CustomPicker.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/07/2023.
//

import SwiftUI

struct CustomPicker: View {
    var data: [ String ]
    var title: String
    @Binding var selected: String

    var body: some View {
        Picker ( selection: $selected, label: Text ( title ) ) {
            ForEach ( self.data, id: \.self ) {
                Text ( $0 )
            }
        }
    }
    
}
