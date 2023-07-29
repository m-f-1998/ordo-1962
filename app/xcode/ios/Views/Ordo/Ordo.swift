//
//  Ordo.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 19/04/2023.
//

import SwiftUI

struct Ordo: View {
    @EnvironmentObject var propers: PropersAPI
    @EnvironmentObject var ordo: OrdoAPI
    @Binding var search_text: String

    var data: OrdoData = DUMMY_ORDO
    var year: String? = UserDefaults.standard.string ( forKey: "year" )

    var body: some View {
        ScrollViewReader { proxy in
            NavigationStack {
                VStack ( spacing: 0 ) {
                    List ( Calendar.current.monthSymbols, id: \.self ) { month in
                        if self.data [ month ]!.count > 0 {
                            Section ( header: Spacer ( minLength: 0 ) ) {
                                ForEach ( 0...self.data [ month ]!.count-1, id: \.self ) { index in
                                    let day = Int ( self.data [ month ]![ index ].date.suffix ( 2 ) )! - 1
                                    Row ( feast: self.data [ month ]![ index ], index: day, month: month )
                                        .padding ( [ .top, .bottom ], 8 )
                                        .redacted ( reason: self.data == DUMMY_ORDO ? .placeholder : [] )
                                        .id ( self.data [ month ]![ index ].id )
                                }
                            }
                        }
                    }
                        .scrollIndicators ( .hidden )
                        .onChange ( of: self.data ) { _ in
                            if case .success ( _ ) = self.ordo.res {
                                if self.search_text == "" {
                                    if self.year == CurrentYear ( ) {
                                        if let id = self.ordo.GetIDToday ( ) {
                                            proxy.scrollTo ( id, anchor: .top )
                                        }
                                    } else {
                                        proxy.scrollTo ( "January", anchor: .top )
                                    }
                                }
                            }
                        }
                        .searchable ( text: self.$search_text, placement: .navigationBarDrawer(displayMode: .always) )
                        .navigationTitle ( "1962 Liturgical Ordo" )
                        .NavBarGradient ( from: .blue.opacity ( 0.3 ), to: .green.opacity ( 0.5 ) )
                        
                    VStack ( spacing: 0 ) {
                        ToolBar ( data: self.data, proxy: proxy, search: self.search_text != "" )
                        Text ( "Year: \( UserDefaults.standard.string ( forKey: "year" ) ?? CurrentYear ( ) )" )
                            .font ( .system ( .caption ) )
                            .padding ( [ .bottom ], 10 )
                    }
                        .background ( LinearGradient ( ).overlay ( .ultraThinMaterial ) )
                }
            }
        }
            .task {
                await self.propers.Update ( )
            }
    }

}
