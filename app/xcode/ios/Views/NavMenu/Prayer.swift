//
//  Prayers.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 02/06/2023.
//

import SwiftUI

struct PrayerView: View {
    var text: String
    var title: String
    var top_padding: Bool = true
    @State var show_latin: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView ( .vertical, showsIndicators: false ) {
                Text ( try! AttributedString ( markdown: text, options: .init ( interpretedSyntax: .inlineOnlyPreservingWhitespace ) ) )
                    .bold ( )
                    .lineSpacing ( 10 )
                    .frame ( minHeight: proxy.size.height )
                    .font ( .system ( .body, design: .monospaced ) )
                    .padding ( [ .leading, .trailing, .top ], 20 )
            }
                .multilineTextAlignment ( .center )
        }
        .navigationBarTitleDisplayMode ( .inline )
    }
}

struct Prayer: View {
    @EnvironmentObject var prayers: PrayerAPI
    
    var languages: [ String ] = [ "English", "Latin" ]
    @State var lang: String = UserDefaults.standard.string ( forKey: "prayers-lang" )!
    @ObservedObject var net: NetworkMonitor = NetworkMonitor ( )

    var body: some View {
        VStack {
            if case let .failure ( res ) = prayers.res {
                VStack ( alignment: .center ) {
                    Text ( res )
                        .multilineTextAlignment ( .center )
                        .padding ( )
                }
            } else {
                NavigationStack {
                    List {
                        if case let .success ( res ) = prayers.res {
                            ForEach ( Array ( res.keys ).sorted ( by: < ), id: \.self ) { category in
                                Section ( header: Text ( category ) ) {
                                    ForEach ( Array ( ( res [ category ]! as PrayerData ).keys ).sorted ( by: < ), id: \.self ) { index in
                                        NavigationLink ( destination: PrayerView ( text: ( res [ category ]! as PrayerData ) [ index ]!, title: index, top_padding: false ) ) {
                                            Text ( index )
                                        }
                                    }
                                }
                            }
                        } else if case .loading = prayers.res {
                            HStack ( alignment: .center, spacing: 10 ) {
                                Text ( "Loading..." )
                            }
                        }
                    }
                    .navigationTitle ( "Prayers" )
                    .toolbar {
                        if ( net.connected ) {
                            Menu ( content: {
                                Options ( data: self.languages, title: "Prayer Language", selected: self.$lang )
                                    .onChange ( of: lang ) { change in
                                        prayers.SetLoading ( )
                                        UserDefaults.standard.set ( change, forKey: "prayers-lang" )
                                        Task {
                                            await prayers.Update ( ignore_cache: true, lang: change )
                                        }
                                    }
                            }, label: { Label ( "Prayer Language", systemImage: "character.bubble" ) } )
                        }
                    }
                    .frame ( maxWidth: .infinity )
                    .safeAreaInset ( edge: .top ) {
                        EmptyView ( ).frame ( height: 13 )
                    }
                }
            }
        }
            .task {
                await prayers.Update ( lang: self.lang )
            }
    }
}
