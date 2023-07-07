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
        Text ( title )
            .font ( .title )
            .bold ( )
            .multilineTextAlignment ( .center )
            .frame ( maxWidth: .infinity )
            .padding ( [ .bottom ], 10 )
            .background ( LinearGradient ( ).overlay ( .ultraThinMaterial ) )

        GeometryReader { proxy in
            VStack {
                ScrollView ( .vertical, showsIndicators: false ) {
                    Text ( text )
                        .bold ( )
                        .lineSpacing ( 10 )
                        .frame ( minHeight: proxy.size.height )
                        .font ( .system ( .title2, design: .rounded ) )
                }
            }
                .padding ( [ .leading, .trailing ], 20 )
                .multilineTextAlignment ( .center )
        }
    }
}

struct Prayer: View {
    @Binding var open_tab: Bool
    @EnvironmentObject var prayers: PrayerAPI

    var body: some View {
        NavigationView {
            VStack {
                if case let .success ( res ) = prayers.res {
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
            await prayers.Update ( )
        }
    }
}
