//
//  DisplayPropers.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 17/12/2023.
//

import SwiftUI

struct DisplayPropers: View {
    var celebrations: [ CelebrationData ]
    var languages: [ String ] = [ "English", "Latin" ]

    @State private var celebration_selection: Int = 0
    @State private var lang: String = UserDefaults.standard.string ( forKey: "propers-lang" )!

    var body: some View {
        VStack ( spacing: 0 ) {
            DisplayText ( text: self.celebrations [ celebration_selection ].GetPropers ( lang: UserDefaults.standard.string ( forKey: "propers-lang" )! ) )
            Picker ( selection: $celebration_selection, label: EmptyView ( ) ) {
                ForEach ( Array ( self.celebrations.enumerated ( ) ), id: \.offset ) { index, element in
                    Text ( element.title.count > 40 ? element.title.prefix ( 40 ) + "..." : element.title )
                        .tag ( index )
                        .font ( .footnote )
                        .bold ( )
                }
            }
            .pickerStyle ( .menu )
            .frame ( maxWidth: .infinity, alignment: .center )
            .padding ( [ .vertical ], 4 )
            .background ( Color ( .systemGray6 ) )
        }.toolbar {
            ToolbarItem {
                Menu {
                    ForEach ( self.languages, id: \.self ) { language in
                        Button {
                            self.lang = language
                            UserDefaults.standard.set ( language, forKey: "propers-lang" )
                        } label: {
                            if language == self.lang {
                                Label ( language, systemImage: "checkmark" )
                            } else {
                                Text ( language )
                            }
                        }
                    }
                } label: {
                    Label ( "Propers Language", systemImage: "character.bubble" )
                }
            }
        }
    }
}
