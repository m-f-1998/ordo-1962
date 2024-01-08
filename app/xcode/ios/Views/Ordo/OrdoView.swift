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
                VStack ( spacing: 0 ) {
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
                    HStack {
                        if CurrentYear ( ) == self.year && self.search == "" {
                            Button {
                                let formatter = DateFormatter ( )
                                formatter.dateFormat = "E dd MMM"
                                DispatchQueue.main.async {
                                    proxy.scrollTo ( formatter.string ( from: .now ), anchor: .top )
                                }
                            } label: {
                                Text ( "Go To Today" )
                                    .font ( .footnote )
                                    .bold ( )
                            }
                            Text ( " | " )
                                .font ( .footnote )
                                .foregroundColor ( .secondary )
                        }
                        Text ( "Year: \( String ( self.year ) )" )
                            .font ( .footnote )
                            .foregroundColor ( .secondary )
                        Text ( " | " )
                            .font ( .footnote )
                            .foregroundColor ( .secondary )
                        Text ( "Version: \( Bundle.main.infoDictionary? [ "CFBundleShortVersionString" ] as? String ?? "Not Found" )" )
                            .font ( .footnote )
                            .foregroundColor ( .secondary )
                    }
                    .frame ( maxWidth: .infinity, alignment: .center )
                    .padding ( [ .vertical ], 8 )
                    .background ( Color ( .systemGray6 ) )
                }
                .scrollIndicators ( .hidden )
                .toolbar {
                    ToolbarItem ( placement: .automatic ) {
                        HStack {
                            Menu {
                                ForEach ( CurrentYear ( )...CurrentYear ( ) + 5, id: \.self ) { year in
                                    if year == self.year {
                                        Menu {
                                            ForEach ( Array ( Calendar.current.shortMonthSymbols.enumerated ( ) ), id: \.offset ) { index, month in
                                                Button {
                                                    DispatchQueue.main.async {
                                                        proxy.scrollTo ( month, anchor: .top )
                                                    }
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
                                Label ( "Change Date", systemImage: "arrow.up.arrow.down")
                            }
                            NavigationLink ( destination:  HelpComponent ( ) ) {
                                Label ( "Information", systemImage: "info.circle" )
                            }
                        }
                    }
                }
                .onAppear {
                    if self.first_load {
                        if !( CurrentMonth ( ) == "Jan" && CurrentDay ( ) == 1 ) {
                            proxy.scrollTo ( self.activeData.GetIDToday ( ), anchor: .top )
                        }
                        self.first_load = false
                    }
                }
            }
        }
            .searchable ( text: self.$search )
    }
}
