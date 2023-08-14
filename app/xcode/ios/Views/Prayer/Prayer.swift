//
//  Prayers.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 02/06/2023.
//

import SwiftUI

struct Prayer: View {
    @EnvironmentObject var prayers: PrayerAPI
    @EnvironmentObject var net: NetworkMonitor

    private var languages: [ String ] = [
        "English",
        "Latin"
    ]
    @State private var lang: String = UserDefaults.standard.string ( forKey: "prayers-lang" )!

    var body: some View {
        VStack {
            if case let .failure ( res ) = prayers.res {
                ErrorView ( description: res, Callback: self.prayers.ErrorRetry )
            } else {
                NavigationStack {
                    List {
                        if case let .success ( res ) = prayers.res {
                            ForEach ( res.keys.sorted ( by: < ), id: \.self ) { category in
                                Section ( header: Text ( category ) ) {
                                    ForEach ( res [ category ]!.keys.sorted ( by: < ), id: \.self ) { prayer in
                                        NavigationLink ( destination: TextDisplay ( text: res [ category ]! [ prayer ]! ) ) {
                                            Text ( prayer )
                                        }
                                    }
                                }
                            }
                        } else if case .loading = prayers.res {
                            Section ( header: Text ( "" ) ) {
                                Text ( "Loading..." )
                            }
                        }
                    }
                    .navigationTitle ( "Prayer" )
                    .toolbar {
                        if net.connected {
                            Menu ( content: {
                                CustomPicker ( data: self.languages, title: "Prayer Language", selected: self.$lang )
                                    .onChange ( of: lang ) { change in
                                        self.prayers.SetLoading ( )
                                        Task {
                                            await self.prayers.Update ( lang: change, use_cache: false )
                                            UserDefaults.standard.set ( change, forKey: "prayers-lang" )
                                        }
                                    }
                                    .disabled ( self.prayers.GetLoading ( ) )
                            }, label: {
                                Label ( "Prayer Language", systemImage: "character.bubble" )
                            } )
                        }
                    }
                        .frame ( maxWidth: .infinity )
                }
            }
        }
    }
}
