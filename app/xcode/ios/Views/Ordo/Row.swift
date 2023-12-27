//
//  Row.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import SwiftUI

struct Row: View {
    let feast: OrdoDay
    let month: String
    let year: String
    @State private var menu_expanded: Bool = false

    var body: some View {
        HStack {
            let date = self.feast.date, components = date.components ( separatedBy: " " )
            DisplayDate ( day: components [ 0 ], date: components [ 1 ], month: self.month, dateObj: FormatDate ( short: true ).date ( from: "\(date) \(self.month) \(year)" )! )
            LazyVStack ( alignment: .leading ) {
                Feast ( data: self.feast.celebrations )
                ScrollView ( .horizontal, showsIndicators: false ) {
                    Tag (
                        title: self.feast.season.title,
                        colors: self.feast.season.colors.components ( separatedBy: "," ).map {
                            Color ( word: $0 )!.opacity ( 0.5 )
                        }
                    )
                    .padding ( [ .trailing, .leading ], 2 )
                }
            }
        }
        .contentShape ( Rectangle ( ) )
        .background (
            NavigationLink ( "", destination: DisplayPropers ( celebrations: self.feast.celebrations ) )
                .disabled (  self.feast.celebrations [ 0 ].propers.count == 0 )
                .opacity ( self.feast.celebrations [ 0 ].propers.count == 0 ? 0 : 1 )
        )
    }
}
