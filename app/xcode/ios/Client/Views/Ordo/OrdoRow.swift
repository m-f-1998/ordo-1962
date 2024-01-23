//
//  Row.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import SwiftUI

struct OrdoRow: View {
    let feast: OrdoDay
    let year: String
    @State private var menu_expanded: Bool = false
    
    var body: some View {
        HStack ( spacing: 10 ) {
            DisplayDate ( date: feast.date )
            VStack ( alignment: .leading ) {
                OrdoFeast ( data: self.feast.celebrations )
                HStack ( spacing: 5 ) {
                    Tag (
                        title: self.feast.season.title,
                        colors: self.feast.season.colors.components ( separatedBy: "," ).map {
                            Color ( word: $0 )!
                        }
                    )
                }.padding ( [ .top ], 5 )
                if !self.feast.fasting.isEmpty {
                    HStack ( spacing: 5 ) {
                        ForEach ( self.feast.fasting, id: \.self ) { fast in
                            Tag (
                                title: fast,
                                colors: [ Color ( word: "v" )! ]
                            )
                        }
                    }.padding ( [ .top ], 5 )
                }
            }
        }
    }
}
