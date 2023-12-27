//
//  Prayers.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 02/06/2023.
//

import SwiftUI

struct Prayer: View {
    @EnvironmentObject var activeData: ActiveData
    @State private var lang: String = UserDefaults.standard.string ( forKey: "prayers-lang" )!

    var body: some View {
        VStack {
            NavigationStack {
                if let prayers = activeData.prayers {
                    List ( prayers.GetCategories ( lang: self.lang ), id: \.self ) { category in
                        Section ( category ) {
                            ForEach ( prayers.GetPrayerNames ( lang: self.lang, cat: category ), id: \.self ) { name in
                                NavigationLink ( name ) {
                                    DisplayText ( text: prayers.GetPrayer ( lang: self.lang, category: category, name: name ) )
                                }
                            }
                        }
                    }
                        .navigationBarTitleDisplayMode ( .inline )
                        .navigationTitle ( "Prayer" )
                        .toolbar {
                            Menu {
                                ForEach ( (self.activeData.prayers?.GetLanguageDetails ( ))!, id: \.self ) { prayer in
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
                            } label: {
                                Label ( "Propers Language", systemImage: "character.bubble" )
                            }.disabled ( self.activeData.loading )
                        }
                }
            }
        }
    }
}
