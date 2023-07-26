//
//  PropersButton.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import SwiftUI

struct PropersButton: View {
    @State private var showing_sheet = false
    let title: String, content: PropersLanguage?
    
    var languages: [ String ] = [ "English", "Latin" ]
    @State var lang: String = "English"

    var body: some View {
        if let proper = self.content {
            Button {
                self.showing_sheet.toggle ( )
            } label: {
                Text ( self.title )
                    .padding ( )
                    .frame ( maxWidth: .infinity )
                    .background ( LinearGradient ( ) )
                    .clipShape ( Rectangle ( ) )
                    .scaledFont ( size: 14 )
                    .cornerRadius ( 10 )
                    .lineLimit ( 1 )
                    .minimumScaleFactor ( 0.85 )
                    .bold ( )
            }
                .sheet ( isPresented: $showing_sheet ) {
                    NavigationStack {
                        VStack {
                            switch self.lang {
                                case "English":
                                    TextDisplay ( text: proper.english )
                                default:
                                    TextDisplay ( text: proper.latin )
                            }
                        }
                            .navigationTitle ( self.title )
                            .toolbar {
                                Menu ( content: {
                                    CustomPicker ( data: self.languages, title: "Propers Language", selected: self.$lang )
                                        .frame ( maxWidth: .infinity )
                                        .padding ( [ .top, .bottom ], 10 )
                                }, label: { Label ( "Propers Language", systemImage: "character.bubble" ) } )
                            }
                    }
                }
        } else {
            fatalError ( "\(self.title) Did Not Appear. Content: \(self.content?.english ?? "Unknown")" )
        }
    }
}

