//
//  PropersButton.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import SwiftUI

struct PropersButton: View {
    @State private var showing_text = false
    let title: String, content: PropersLanguage?
    @State var langague: String = UserDefaults.standard.string ( forKey: "propers-lang" )!

    var body: some View {
        if let proper = self.content {
            Button {
                self.langague = UserDefaults.standard.string ( forKey: "propers-lang" )!
                self.showing_text.toggle ( )
            } label: {
                Text ( self.title )
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
                    switch self.langague {
                    case "English":
                        TextDisplay ( text: proper.english )
                    default:
                        TextDisplay ( text: proper.latin )
                    }
                }
                    .navigationTitle ( self.title )
            } )
        } else {
            fatalError ( "\(self.title) Did Not Appear. Content: \(self.content?.english ?? "Unknown")" )
        }
    }
}

