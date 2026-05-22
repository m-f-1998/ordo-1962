//
//  Ordo.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 19/04/2023.
//

import SwiftUI

struct OrdoView: View {
    @Environment(ActiveData.self) var activeData
    
    @State var search: String = ""
    @State var first_load: Bool = true
    @State var year: Int = CurrentYear ( )
    @State var searchIsActive = false
    @State private var showGoToDate = false
    @FocusState private var searchFocused: Bool

    var body: some View {
        ScrollViewReader { proxy in
            NavigationStack {
                OrdoEventList ( search: self.$search, year: self.$year, searchIsActive: self.$searchIsActive )
                    .scrollDismissesKeyboard ( .immediately )
                    .scrollIndicators ( .hidden )
                    .navigationBarTitleDisplayMode ( .inline )
                    // Search bar slides in when active
                    .safeAreaInset ( edge: .top, spacing: 0 ) {
                        if searchIsActive {
                            HStack ( spacing: 10 ) {
                                Image ( systemName: "magnifyingglass" )
                                    .foregroundStyle ( .secondary )
                                    .font ( .system ( size: 15 ) )
                                TextField ( "Search feasts and seasons…", text: $search )
                                    .textFieldStyle ( .plain )
                                    .autocorrectionDisabled ( )
                                    .textInputAutocapitalization ( .never )
                                    .focused ( $searchFocused )
                                    .submitLabel ( .search )
                                if !search.isEmpty {
                                    Button {
                                        search = ""
                                    } label: {
                                        Image ( systemName: "xmark.circle.fill" )
                                            .foregroundStyle ( .secondary )
                                    }
                                }
                                Button ( "Cancel" ) {
                                    search = ""
                                    searchIsActive = false
                                    searchFocused = false
                                }
                                .font ( .system ( size: 15 ) )
                            }
                            .padding ( .horizontal, 14 )
                            .padding ( .vertical, 9 )
                            .background ( .regularMaterial )
                            .overlay ( Rectangle ( ).frame ( height: 0.5 ).foregroundStyle ( Color ( .systemGray4 ) ), alignment: .bottom )
                            .transition ( .move ( edge: .top ).combined ( with: .opacity ) )
                        }
                    }
                    .toolbar {
                        ToolbarItemGroup ( placement: .topBarTrailing ) {
                            Button {
                                withAnimation ( .spring ( response: 0.3, dampingFraction: 0.8 ) ) {
                                    searchIsActive = true
                                }
                            } label: {
                                Image ( systemName: "magnifyingglass" )
                                    .fontWeight ( .medium )
                            }
                            OrdoToolbar ( proxy: proxy, year: self.$year )
                        }

                        ToolbarItemGroup ( placement: .topBarLeading ) {
                            if self.search.isEmpty && !searchIsActive {
                                if CurrentYear ( ) == self.year {
                                    Menu {
                                        Button {
                                            withAnimation {
                                                proxy.scrollTo ( self.activeData.GetIDToday ( ), anchor: .top )
                                            }
                                        } label: {
                                            Label ( "Go To Today", systemImage: "calendar.circle.fill" )
                                        }
                                        Button {
                                            showGoToDate = true
                                        } label: {
                                            Label ( "Go To Date…", systemImage: "calendar.badge.clock" )
                                        }
                                    } label: {
                                        Image ( systemName: "calendar" )
                                            .fontWeight ( .medium )
                                    }
                                } else {
                                    Button {
                                        showGoToDate = true
                                    } label: {
                                        Image ( systemName: "calendar" )
                                            .fontWeight ( .medium )
                                    }
                                }
                            }
                        }
                    }
                    .onChange ( of: searchIsActive ) { _, active in
                        if active {
                            searchFocused = true
                        }
                    }
                    .onChange ( of: self.search ) { old, new in
                        if new.isEmpty && !searchIsActive {
                            proxy.scrollTo ( "Jan" )
                        }
                    }
                    .onAppear {
                        if self.first_load {
                            if !( CurrentMonth ( ) == "Jan" && CurrentDay ( ) == 1 ) {
                                withAnimation {
                                    proxy.scrollTo ( self.activeData.GetIDToday ( ), anchor: .top )
                                }
                            }
                            self.first_load = false
                        }
                    }
                    .sheet ( isPresented: $showGoToDate ) {
                        GoToDateSheet ( year: self.year, onSelect: { date in
                            showGoToDate = false
                            let cal = Calendar.current
                            let month = cal.shortMonthSymbols [ cal.component ( .month, from: date ) - 1 ]
                            let day   = cal.component ( .day, from: date )
                            let target = activeData.GetYear ( year: year )?.getDay ( month: month, day: day )
                            if let id = target?.date.combined {
                                withAnimation {
                                    proxy.scrollTo ( id, anchor: .top )
                                }
                            }
                        } )
                    }
            }
        }
    }
}
