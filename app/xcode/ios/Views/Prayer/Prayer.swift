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
            if self.prayers.GetLoading ( ) {
                ProgressView {
                    Text ( "Loading..." )
                }
            } else if case let .failure ( error ) = prayers.res {
                ErrorView ( description: error, Callback: self.prayers.ErrorRetry )
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
                            Menu ( content: {
                                CustomPicker ( data: Array ( res.keys ).sorted ( by: < ), title: "Prayer Language", selected: self.$lang )
                                    .onChange ( of: lang ) { change in
                                        UserDefaults.standard.set ( change, forKey: "prayers-lang" )
                                    }
                                    .disabled ( self.prayers.GetLoading ( ) )
                            }, label: {
                                Label ( "Prayer Language", systemImage: "character.bubble" )
                            } )
                        }
                }
            }
        }
    }
}
