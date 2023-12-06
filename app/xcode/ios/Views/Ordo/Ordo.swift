//
//  Ordo.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 19/04/2023.
//

import SwiftUI

struct Ordo: View {
    @EnvironmentObject var ordo: OrdoAPI
    
    @State private var lang: String = UserDefaults.standard.string ( forKey: "propers-lang" )!
    @State var search_text: String = ""
    @State var first_load: Bool = true
    @Environment(\.isSearching) var isSearching
    
    @State var data: OrdoMonth = DUMMY_ORDO
    var languages: [ String ] = [ "English", "Latin" ]
    @State var year: Int = CurrentYear ( )
    @State var change_date_position: Date = .distantPast
    @Binding var second_tap: Bool
    @State var month: String = CurrentMonth ( )

    var body: some View {
            NavigationStack {
                ScrollViewReader { proxy in
                    List ( Calendar.current.shortMonthSymbols, id: \.self ) { month in
                        if self.data [ month ]!.count > 0 {
                            Section ( header: Spacer ( minLength: 0 ) ) {
                                ForEach ( 0...self.data [ month ]!.count-1, id: \.self ) { index in
                                    Row ( feast: self.data [ month ]![ index ], month: month )
                                        .id ( self.data [ month ]![ index ].id )
                                        .padding ( [ .top, .bottom ], 8 )
                                        .redacted ( reason: self.data == DUMMY_ORDO ? .placeholder : [] )
                                        .onAppear {
                                            if self.month != month && self.change_date_position == .distantPast && self.data != DUMMY_ORDO {
                                                self.month = month
                                            }
                                        }
                                        .ignoresSafeArea ( .keyboard )
                                }
                            }
                        }
                    }
                    .searchable ( text: self.$search_text )
                    .scrollDisabled ( data == DUMMY_ORDO )
                    .scrollIndicators ( .hidden )
                    .navigationTitle ( "1962 Ordo" )
                    .toolbar {
                        ToolbarItem ( placement: .automatic ) {
                            HStack {
                                Menu {
                                    Section ( "Language in Propers" ) {
                                        ForEach ( self.languages, id: \.self ) { language in
                                            Button {
                                                self.lang = language
                                                UserDefaults.standard.set ( language, forKey: "propers-lang" )
                                            } label: {
                                                if language == self.lang {
                                                    Label ( language, systemImage: "checkmark" )
                                                } else {
                                                    Text ( language )
                                                }
                                            }
                                        }
                                    }
                                } label: {
                                    Label ( "Propers Language", systemImage: "character.bubble" )
                                }
                                Menu {
                                    ForEach ( CurrentYear ( )...CurrentYear ( ) + 10, id: \.self ) { year in
                                        Menu {
                                            ForEach ( Calendar.current.shortMonthSymbols, id: \.self ) { month in
                                                Button {
                                                    self.GoToDate ( month: month, year: year, proxy: proxy )
                                                } label: {
                                                    if month == self.month && year == self.year {
                                                        Label ( month, systemImage: "checkmark" )
                                                    } else {
                                                        Text ( month )
                                                    }
                                                }
                                            }
                                        } label: {
                                            if year == self.year {
                                                Label ( String ( year ), systemImage: "checkmark" )
                                            } else {
                                                Text ( String ( year ) )
                                            }
                                        }
                                    }
                                } label: {
                                    Label ( "Change Date", systemImage: "calendar")
                                }
                            }
                                .disabled ( data == DUMMY_ORDO )
                        }
                    }
                    .NavBarGradient ( from: .blue.opacity ( 0.3 ), to: .green.opacity ( 0.5 ) )
                    .onChange ( of: self.change_date_position, perform: { change in
                        if change != .distantPast && self.data != DUMMY_ORDO {
                            let components = Calendar.current.dateComponents ( [ .day, .month, .year ], from: change )
                            let id = self.data [ Calendar.current.shortMonthSymbols [ components.month! - 1 ] ]! [ components.day! - 1 ].id
                            proxy.scrollTo ( id, anchor: .top )
                            self.change_date_position = .distantPast
                        }
                    } )
                    .onChange ( of: self.second_tap, perform: { tapped in
                        if tapped {
                            withAnimation {
                                proxy.scrollTo ( self.data [ "Jan" ]?.first!.id, anchor: .top )
                                self.second_tap = false
                            }
                        }
                    } )
                    .onChange ( of: self.search_text, perform: { change in
                        Task {
                            self.data = self.ordo.GetResult ( search: change )
                        }
                    } )
                    .onAppear {
                        if self.first_load {  // Required for Cache to Run on Load
                            self.change_date_position = .now
                            self.first_load = false
                        }
                    }
                }
            }
            .onChange ( of: self.ordo.res, perform: { change in
                if case let .success ( data ) = change {
                    self.data = data
                }
            })
        .onAppear {
            self.data = self.ordo.GetResult ( search: self.search_text )
        }
    }
    
    func GoToDate ( month: String, year: Int, proxy: ScrollViewProxy ) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        self.month = month

        if year != self.year {
            self.data = DUMMY_ORDO
            self.year = year
            Task {
                if case let .success ( res ) = await self.ordo.GetCache ( year: year ) {
                    self.data = res
                }
            }
        }
            
        self.change_date_position = formatter.date ( from: "01 \(month) \(year)" )!
    }
}
