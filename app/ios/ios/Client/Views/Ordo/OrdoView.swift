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
    @State private var goToDate: Date = .now

    private var theme: LiturgicalTheme {
        if let today = activeData.GetYear ( )?.getDay ( month: CurrentMonth ( ), day: CurrentDay ( ) ) {
            return LiturgicalTheme ( day: today )
        }
        return LiturgicalTheme ( colors: "g" )
    }

    var body: some View {
        ScrollViewReader { proxy in
            NavigationStack {
                OrdoEventList ( search: self.$search, year: self.$year, searchIsActive: self.$searchIsActive )
                    .searchable ( text: self.$search, isPresented: $searchIsActive, placement: .navigationBarDrawer ( displayMode: .always ) )
                    .scrollDismissesKeyboard ( .immediately )
                    .scrollIndicators ( .hidden )
                    .navigationBarTitleDisplayMode ( .inline )
                    .toolbar {
                        // Glass title in the centre
                        ToolbarItem ( placement: .principal ) {
                            GlassTitleBar ( accent: theme.accent )
                        }

                        ToolbarItemGroup ( placement: .topBarTrailing ) {
                            // Smooth search activation
                            Button {
                                withAnimation ( .spring ( response: 0.35, dampingFraction: 0.75 ) ) {
                                    searchIsActive = true
                                }
                            } label: {
                                Image ( systemName: "magnifyingglass" )
                                    .fontWeight ( .medium )
                            }
                            OrdoToolbar ( proxy: proxy, year: self.$year )
                        }

                        // Go To Today + Go To Date on the leading side
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
                                            goToDate = .now
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
                                        goToDate = .now
                                        showGoToDate = true
                                    } label: {
                                        Image ( systemName: "calendar" )
                                            .fontWeight ( .medium )
                                    }
                                }
                            }
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
