//
//  PropersDisplay.swift
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
        VStack {
            DisplayText ( text: self.celebrations [ celebration_selection ].GetPropers ( lang: UserDefaults.standard.string ( forKey: "propers-lang" )! ) )
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
            ToolbarItem ( placement: .bottomBar ) {
                VStack {
                    Menu {
                        Picker ( selection: $celebration_selection, label: EmptyView ( ) ) {
                            ForEach ( Array ( self.celebrations.enumerated ( ) ), id: \.offset ) { index, element in
                                if element.title.count > 40 {
                                    Text ( element.title.prefix ( 40 ) + "..." ).tag ( index )
                                } else {
                                    Text ( element.title ).tag ( index )
                                }
                            }
                        }
                    } label: {
                        if self.celebrations [ celebration_selection ].title.count > 40 {
                            Text ( self.celebrations [ celebration_selection ].title.prefix ( 40 ) + "..." )
                                .bold ( )
                                .font ( .footnote )
                        } else {
                            Text ( self.celebrations [ celebration_selection ].title )
                                .bold ( )
                                .font ( .footnote )
                        }
                    }
                    Spacer ( )
                }
            }
        }
    }
}
