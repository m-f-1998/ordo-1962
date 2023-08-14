//
//  PropersButton.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import SwiftUI

struct PropersButton: View {
    @State private var showing_text = false

    let content: FeastPropers
    @State var index: Int
    let titles: [ String ] = [ "Introit", "Collect", "Epistle", "Gradual", "Gospel", "Offertory", "Secret", "Preface", "Communion", "Postcommunion" ]

    @State var langague: String = UserDefaults.standard.string ( forKey: "propers-lang" )!

    var body: some View {
        Button {
            self.langague = UserDefaults.standard.string ( forKey: "propers-lang" )!
            self.showing_text.toggle ( )
        } label: {
            Text ( self.titles [ self.index ].uppercased ( ) )
                .padding ( )
                .frame ( maxWidth: .infinity )
                .background ( LinearGradient ( ) )
                .clipShape ( Rectangle ( ) )
                .scaledFont ( size: 14 )
                .cornerRadius ( 10 )
                .lineLimit ( 1 )
                .minimumScaleFactor ( 0.8 )
                .bold ( )
        }
        .navigationDestination ( isPresented: $showing_text, destination: {
            VStack {
                HStack {
                    Button {
                        self.index -= 1
                    } label: {
                        Image ( systemName: "chevron.backward.circle" )
                            .resizable ( )
                            .frame ( maxWidth: 20, maxHeight: 20 )
                    }
                        .disabled ( index == 0 )
                        .padding ( [ .trailing ], 10 )
                    Button {
                        self.index += 1
                    } label: {
                        Image ( systemName: "chevron.forward.circle" )
                            .resizable ( )
                            .frame ( maxWidth: 20, maxHeight: 20 )
                    }
                        .disabled ( index == titles.count - 1 )
                        .padding ( [ .leading ], 10 )
                }
                    .padding ( [ .top ], 10 )
                switch self.langague {
                case "English":
                    TextDisplay ( text: self.content.dictionary [ self.titles [ self.index ].lowercased ( ) ]!!.english )
                default:
                    TextDisplay ( text: self.content.dictionary [ self.titles [ self.index ].lowercased ( ) ]!!.latin )
                }
            }
            .navigationTitle ( self.titles [ self.index ].uppercased ( ) )
        } )
    }
}

