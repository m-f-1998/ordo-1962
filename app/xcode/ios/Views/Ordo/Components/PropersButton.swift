//
//  PropersButton.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import SwiftUI

struct PropersButton: View {
    let content: FeastPropers
    let season: String
    let feast_title: String
    var titles: [ String ] = [ "Introit", "Collect", "First Lesson", "First Gradual", "First Collect", "Second Lesson", "Second Gradual", "Second Collect", "Third Lesson", "Third Gradual", "Third Collect", "Fourth Lesson", "Fourth Gradual", "Fourth Collect", "Fifth Lesson", "Fifth Collect", "Epistle", "Gradual", "Sequence", "Gospel", "Offertory", "Secret", "Preface", "Communion", "Postcommunion", "Prayer Over The People" ]

    @State private var langague: String = UserDefaults.standard.string ( forKey: "propers-lang" )!
    @State private var selection = "Introit"
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
            TextDisplay ( text: self.content.dictionary [ self.selection.lowercased ( ) ]!!.dictionary [ self.langague.lowercased() ]! )
                .toolbar {
                    ToolbarItem ( placement: .automatic ) {
                        Picker ( selection: $selection, label: Label ( "Proper", systemImage: "book" ) ) {
                            ForEach ( self.titles, id: \.self ) {
                                if self.content.dictionary [ $0.lowercased ( ) ]! != nil {
                                    Text ( $0 )
                                }
                            }
                        }
                    }
                }
        } )
    }
}

