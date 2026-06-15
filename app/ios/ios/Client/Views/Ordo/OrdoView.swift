//
//  OrdoView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 19/04/2023.
//

import SwiftUI

struct OrdoView: View {
    @Environment(ActiveData.self) var activeData
    @Environment(TabStateHandler.self) private var tabState

    @State var search: String = ""
    @State var first_load: Bool = true
    @State var year: Int = CurrentYear ( )
    @State private var showGoToDate = false
    @State private var currentlyViewingDate: Date = .now

    var body: some View {
        ScrollViewReader { proxy in
            NavigationStack {
                OrdoEventList ( search: self.$search, year: self.$year, searchIsActive: Binding (
                    get: { tabState.isSearching },
                    set: { tabState.isSearching = $0 }
                ) )
                    .scrollDismissesKeyboard ( .immediately )
                    .scrollIndicators ( .hidden )
                    .navigationBarTitleDisplayMode ( .inline )
                    .searchable ( text: $search, isPresented: Binding (
                        get: { tabState.isSearching },
                        set: { tabState.isSearching = $0 }
                    ), prompt: "Search feasts and seasons…" )
                    .toolbar {
                        ToolbarItemGroup ( placement: .topBarTrailing ) {
                            Menu {
                                Button {
                                    if self.year != CurrentYear ( ) {
                                        self.year = CurrentYear ( )
                                    }
                                    currentlyViewingDate = .now
                                    DispatchQueue.main.asyncAfter ( deadline: .now ( ) + 0.1 ) {
                                        withAnimation {
                                            proxy.scrollTo ( "today-card", anchor: .top )
                                        }
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
                        }
                    }
                    .onChange ( of: self.search ) { old, new in
                        if new.isEmpty && !tabState.isSearching {
                            proxy.scrollTo ( "Jan" )
                        }
                    }
                    .onChange ( of: self.year ) { _, newYear in
                        if newYear == CurrentYear ( ) {
                            currentlyViewingDate = .now
                        } else {
                            currentlyViewingDate = Calendar.current.date ( from: DateComponents ( year: newYear, month: 1, day: 1 ) ) ?? .now
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
                        GoToDateSheet (
                            initialDate: currentlyViewingDate,
                            onSelect: { chosenYear, date in
                                currentlyViewingDate = date
                                let cal = Calendar.current
                                let month = cal.shortMonthSymbols [ cal.component ( .month, from: date ) - 1 ]
                                let day   = cal.component ( .day, from: date )
                                self.year = chosenYear
                                DispatchQueue.main.asyncAfter ( deadline: .now ( ) + 0.1 ) {
                                    let target = activeData.GetYear ( year: chosenYear )?.getDay ( month: month, day: day )
                                    if let id = target?.date.combined {
                                        withAnimation {
                                            proxy.scrollTo ( id, anchor: .top )
                                        }
                                    }
                                }
                            }
                        )
                    }
            }
        }
    }
}
