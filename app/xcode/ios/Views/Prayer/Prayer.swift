//
//  Prayers.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 02/06/2023.
//

import SwiftUI

struct Prayer: View {
    @EnvironmentObject var prayers: PrayerAPI
    @State private var lang: String = UserDefaults.standard.string ( forKey: "prayers-lang" )!

    var body: some View {
        VStack {
            if case .loading = prayers.res {
                ProgressView {
                    Text ( "Loading..." )
                }
           } else if case let .success ( res ) = prayers.res {
                NavigationStack {
                    List ( res [ self.lang ]!.sorted ( by: { $0.0 < $1.0 } ), id: \.key ) { category, prayer in
                        Section ( category ) {
                            ForEach ( prayer.sorted ( by: { $0.0 < $1.0 } ), id: \.key ) { name, text in
                                NavigationLink ( name ) {
                                    TextDisplay ( text: text )
                                }
                            }
                        }
                    }
                        .navigationBarTitleDisplayMode ( .inline )
                        .navigationTitle ( "Prayer" )
                        .toolbar {
                            Menu {
                                Section ( "Language in Prayers" ) {
                                    ForEach ( Array ( res.keys ).sorted ( by: < ), id: \.self ) { prayer in
                                        Button {
                                            self.lang = prayer
                                            UserDefaults.standard.set ( prayer, forKey: "prayers-lang" )
                                        } label: {
                                            if prayer == self.lang {
                                                Label ( prayer, systemImage: "checkmark" )
                                            } else {
                                                Text ( prayer )
                                            }
                                        }
                                    }
                                }
                            } label: {
                                Label ( "Propers Language", systemImage: "character.bubble" )
                            }.disabled ( self.prayers.GetLoading ( ) )
                        }
                }
            }
        }
    }
}
