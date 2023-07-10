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
    @Binding var open_tab: Bool
    @State var show_latin: Bool = false
    
    var body: some View {
        VStack ( spacing: 0 ) {
            Text ( title )
                .font ( .title2 )
                .bold ( )
                .multilineTextAlignment ( .center )
                .frame ( maxWidth: .infinity )
                .padding ( [ .bottom ], 20 )
                .padding ( [ .trailing, .leading ], 20 )
                .background ( LinearGradient ( ).overlay ( .ultraThinMaterial ) )
            
            GeometryReader { proxy in
                VStack {
                    ScrollView ( .vertical, showsIndicators: false ) {
                        Text ( text )
                            .bold ( )
                            .lineSpacing ( 10 )
                            .frame ( maxWidth: .infinity, minHeight: proxy.size.height )
                            .font ( .system ( .body, design: .monospaced ) )
                            .padding ( [ .top, .bottom ], 20 )
                    }
                }
                    .padding ( [ .leading, .trailing ], 20 )
                    .multilineTextAlignment ( .center )
            }
        }
    }
}

struct Prayer: View {
    @Binding var open_tab: Bool
    @EnvironmentObject var prayers: PrayerAPI
    
    var languages: [ String ] = [ "English", "Latin" ]
    @State var lang: String = UserDefaults.standard.string ( forKey: "lang" )!
    @ObservedObject var net: NetworkMonitor = NetworkMonitor ( )

    var body: some View {
        NavigationView {
            VStack {
                if case let .success ( res ) = prayers.res {
                    if ( net.connected ) {
                        Options ( data: self.languages, title: "Prayer Language", selected: self.$lang )
                            .onChange ( of: lang ) { change in
                                prayers.SetLoading ( )
                                UserDefaults.standard.set ( change, forKey: "lang" )
                                Task {
                                    await prayers.Update ( ignore_cache: true, lang: change )
                                }
                            }
                    }
                    List {
                        ForEach ( Array ( res.keys ).sorted ( by: < ), id: \.self ) { category in
                            Section ( header: Text ( category ) ) {
                                ForEach ( Array ( ( res [ category ]! as PrayerData ).keys ).sorted ( by: < ), id: \.self ) { index in
                                    NavigationLink ( destination: PrayerView ( text: ( res [ category ]! as PrayerData ) [ index ]!, title: index, open_tab: $open_tab ) ) {
                                        Text ( index )
                                    }
                                }
                            }
                        }
                    }
                } else if case let .failure ( res ) = prayers.res {
                    VStack ( alignment: .center ) {
                        Text ( res )
                            .multilineTextAlignment ( .center )
                            .padding ( )
                    }
                } else if case .loading = prayers.res {
                    ProgressView ( )
                }
            }.navigationBarItems ( trailing: Button {
                self.open_tab = false
            } label: {
                Text ( "Done" ).bold ( )
            } )
        }.task {
            await prayers.Update ( lang: self.lang )
        }
    }
}
