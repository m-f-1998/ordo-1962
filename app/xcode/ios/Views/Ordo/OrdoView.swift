//
//  Ordo.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 19/04/2023.
//

import SwiftUI

struct OrdoView: View {
    @EnvironmentObject var activeData: ActiveData
    @State var search: String = ""
    @State var first_load: Bool = true
    
    @State var year: Int = CurrentYear ( )
    @Binding var second_tap: Bool

    var searchResults: [ [ OrdoDay ] ] {
        if search.isEmpty {
            return self.activeData.GetYear ( year: year )!.ordo
        } else {
            return self.activeData.GetFilteredOrdo ( search: search, year: year )
        }
    }

    var body: some View {
        ScrollViewReader { proxy in
            NavigationStack {
                List {
                    ForEach ( searchResults, id: \.self ) { month in
                        Section ( header: Spacer ( minLength: 0 ) ) {
                            ForEach ( month ) { day in
                                Row ( feast: day, month: day.month, year: String ( self.year ) )
                                    .id ( "\(day.date) \(day.month)" )
                                    .padding ( [ .top, .bottom ], 8 )
                            }
                        }.id ( month [ 0 ].month )
                    }
                }
                .scrollIndicators ( .hidden )
                .navigationTitle ( "Liturgical Calendar" )
                .toolbar {
                    ToolbarItem ( placement: .automatic ) {
                        HStack {
                            Menu {
                                ForEach ( CurrentYear ( )...CurrentYear ( ) + 5, id: \.self ) { year in
                                    if year == self.year {
                                        Menu {
                                            ForEach ( Array ( Calendar.current.shortMonthSymbols.enumerated ( ) ), id: \.offset ) { index, month in
                                                Button {
                                                    proxy.scrollTo ( month, anchor: .top )
                                                } label: {
                                                    Text ( Calendar.current.monthSymbols [ index ] )
                                                }
                                            }
                                        } label: {
                                            Label ( String ( year ), systemImage: "checkmark" )
                                        }
                                    } else {
                                        Button {
                                            self.year = year
                                            proxy.scrollTo ( "Jan", anchor: .top )
                                        } label: {
                                            Text ( String ( year ) )
                                        }
                                    }
                                }
                            } label: {
                                Label ( "Change Date", systemImage: "calendar")
                            }
                            NavigationLink ( destination:  DisplayText ( text: "", display_ordo_info: true ) ) {
                                Label ( "Information", systemImage: "info.circle" )
                            }
                        }
                    }
                }
                .onChange ( of: self.second_tap ) {
                    withAnimation {
                        proxy.scrollTo ( "Jan", anchor: .top )
                    }
                }
                .onAppear {
                    if self.first_load {
                        proxy.scrollTo ( self.activeData.GetIDToday ( ), anchor: .top )
                        self.first_load = false
                    }
                }
            }
        }
            .searchable ( text: self.$search )
    }
}
