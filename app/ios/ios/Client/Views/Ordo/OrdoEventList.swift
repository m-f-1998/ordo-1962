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
                .background ( theme.accentSubtle )
                .clipShape ( RoundedRectangle ( cornerRadius: 12 ) )
                .overlay (
                    RoundedRectangle ( cornerRadius: 12 )
                        .stroke ( theme.accent.opacity ( 0.25 ), lineWidth: 1 )
                )
            }
            .buttonStyle ( .plain )
            .padding ( [ .horizontal, .top ] )
        }
    }
}

struct OrdoEventList: View, KeyboardReadable {
    @Environment(ActiveData.self) var activeData
    @Binding var search: String
    @Binding var year: Int
    @State private var isKeyboardVisible = false
    @State private var searchResults: [ [ OrdoDay ] ] = []

    private var isCurrentYear: Bool { year == CurrentYear ( ) }

    private var today: OrdoDay? {
        guard isCurrentYear, search.isEmpty else { return nil }
        return activeData.GetYear ( year: year )?.getDay ( month: CurrentMonth ( ), day: CurrentDay ( ) )
    }

    var body: some View {
        List {
            if let todayDay = today {
                Section {
                    TodayCard ( day: todayDay )
                        .listRowInsets ( EdgeInsets ( ) )
                        .listRowBackground ( Color.clear )
                        .listRowSeparator ( .hidden )
                }
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
            .onReceive ( keyboardPublisher ) { newIsKeyboardVisible in
                isKeyboardVisible = newIsKeyboardVisible
            }
            .overlay {
                if self.searchResults.isEmpty, !self.search.isEmpty {
                    ContentUnavailableView.search ( text: self.search )
                }
            }
            .task ( id: search ) {
                let filtered = search.isEmpty
                    ? activeData.GetYear ( year: year )?.ordo ?? []
                    : activeData.GetFilteredOrdo ( search: search, year: year )
                searchResults = filtered
            }
            .task ( id: year ) {
                searchResults = activeData.GetYear ( year: year )?.ordo ?? []
            }
    }
}
