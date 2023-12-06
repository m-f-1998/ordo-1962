//
//  PropersButton.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import SwiftUI

struct PropersButton: View {
    let content: [ PropersLanguage ]
    let season: String
    let feast_title: String

    @State private var langague: String = UserDefaults.standard.string ( forKey: "propers-lang" )!
    @State private var selection = 0
    @State private var showing_text = false

    var body: some View {
        Button {
            self.langague = UserDefaults.standard.string ( forKey: "propers-lang" )!
            self.showing_text.toggle ( )
        } label: {
            Text ( self.feast_title.uppercased ( ) )
                .padding ( )
                .frame ( maxWidth: .infinity )
                .multilineTextAlignment ( .center )
                .background ( LinearGradient ( ) )
                .clipShape ( Rectangle ( ) )
                .scaledFont ( size: 14 )
                .cornerRadius ( 10 )
                .lineLimit ( 3 )
                .minimumScaleFactor ( 0.8 )
                .bold ( )
        }
        .navigationDestination ( isPresented: $showing_text, destination: {
            TextDisplay ( text: self.content [ self.selection ].dictionary [ self.langague.lowercased ( ) ]! )
                .toolbar {
                    ToolbarItem ( placement: .automatic ) {
                        Picker ( selection: $selection, label: Label ( "Proper", systemImage: "book" ) ) {
                            ForEach ( self.content.indices, id: \.self ) {
                                Text ( self.content [ $0 ].title! ).id ( $0 )
                            }
                        }
                    }
                }
        } )
    }
}

