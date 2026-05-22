//
//  OrdoEventList.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 23/01/2024.
//

import SwiftUI

struct TodayCard: View {
    let day: OrdoDay

    private var theme: LiturgicalTheme { LiturgicalTheme ( day: day ) }

    var body: some View {
        if let feast = day.celebrations.first {
            NavigationLink {
                DisplayPropers ( celebrations: day.celebrations.filter { $0.propers.count > 0 } )
            } label: {
                VStack ( alignment: .leading, spacing: 10 ) {
                    HStack {
                        Text ( "Today — \(day.date.combined)" )
                            .font ( .caption )
                            .fontWeight ( .semibold )
                            .foregroundStyle ( theme.accent )
                        Spacer ( )
                        Text ( day.season.title )
                            .font ( .caption )
                            .foregroundStyle ( theme.accent.opacity ( 0.8 ) )
                    }
                    Text ( feast.title )
                        .font ( .system ( size: 18, weight: .semibold, design: .serif ) )
                        .foregroundStyle ( .primary )
                        .multilineTextAlignment ( .leading )
                    HStack ( spacing: 8 ) {
                        Text ( "Class \(feast.rank)" )
                            .font ( .caption )
                            .foregroundStyle ( .secondary )
                        if !day.fasting.isEmpty {
                            Text ( "·" ).foregroundStyle ( .secondary )
                            Text ( day.fasting.joined ( separator: ", " ) )
                                .font ( .caption )
                                .foregroundStyle ( .secondary )
                        }
                    }
                }
                .padding ( )
                .frame ( maxWidth: .infinity, alignment: .leading )
                .background ( .secondarySystemGroupedBackground )
                .clipShape ( RoundedRectangle ( cornerRadius: 12 ) )
                .overlay (
                    RoundedRectangle ( cornerRadius: 12 )
                        .stroke ( theme.accent.opacity ( 0.60 ), lineWidth: 2 )
                )
            }
            .buttonStyle ( .plain )
            .padding ( .horizontal )
        }
    }
}

struct OrdoEventList: View, KeyboardReadable {
    @Environment(ActiveData.self) var activeData
    @Binding var search: String
    @Binding var year: Int
    @Binding var searchIsActive: Bool
    @State private var isKeyboardVisible = false
    @State private var searchResults: [ [ OrdoDay ] ] = []

    private var isCurrentYear: Bool { year == CurrentYear ( ) }

    private var today: OrdoDay? {
        guard isCurrentYear, search.isEmpty, !searchIsActive else { return nil }
        return activeData.GetYear ( year: year )?.getDay ( month: CurrentMonth ( ), day: CurrentDay ( ) )
    }

    var body: some View {
        List {
            if let todayDay = today {
                TodayCard ( day: todayDay )
                    .listRowInsets ( EdgeInsets ( ) )
                    .listRowBackground ( Color.clear )
                    .listRowSeparator ( .hidden )
            }
            ForEach ( searchResults, id: \.self ) { month in
                Section ( header: Spacer ( minLength: 0 ) ) {
                    ForEach ( month ) { day in
                        NavigationLink {
                            DisplayPropers ( celebrations: day.celebrations.filter { $0.propers.count > 0 } )
                        } label: {
                            OrdoRow ( feast: day, year: String ( self.year ) )
                        }
                        .id ( day.date.combined )
                        .padding ( [ .vertical ], 8 )
                        .disabled ( isKeyboardVisible )
                    }
                }
                    .id ( month.first?.date.month ?? "" )
            }
        }
            .listSectionSpacing ( .compact )
            .onReceive ( keyboardPublisher ) { newIsKeyboardVisible in
                isKeyboardVisible = newIsKeyboardVisible
            }
            .overlay {
                if self.searchResults.isEmpty, !self.search.isEmpty {
                    ContentUnavailableView.search ( text: self.search )
                }
            }
            .onChange ( of: searchIsActive ) { _, active in
                if !active {
                    searchResults = activeData.GetYear ( year: year )?.ordo ?? []
                }
            }
            .task ( id: search ) {
                if search.isEmpty {
                    searchResults = activeData.GetYear ( year: year )?.ordo ?? []
                    return
                }
                try? await Task.sleep ( for: .milliseconds ( 80 ) )
                guard !Task.isCancelled else { return }
                guard let snapshot = activeData.getSearchSnapshot ( year: year ) else { return }
                let lower = search.lowercased ( )
                let filtered: [ [ OrdoDay ] ] = await Task.detached ( priority: .userInitiated ) {
                    var result: [ [ OrdoDay ] ] = []
                    var currentMonth = -1
                    var currentGroup: [ OrdoDay ] = []
                    for entry in snapshot.entries where entry.text.contains ( lower ) {
                        let day = snapshot.months [ entry.month ] [ entry.day ]
                        if entry.month != currentMonth {
                            if !currentGroup.isEmpty { result.append ( currentGroup ) }
                            currentGroup = [ day ]
                            currentMonth = entry.month
                        } else {
                            currentGroup.append ( day )
                        }
                    }
                    if !currentGroup.isEmpty { result.append ( currentGroup ) }
                    return result
                }.value
                guard !Task.isCancelled else { return }
                searchResults = filtered
            }
            .task ( id: year ) {
                searchResults = activeData.GetYear ( year: year )?.ordo ?? []
            }
    }
}
