//
//  OrdoEventList.swift
//  ordo-1962
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
                    VStack(alignment: .leading, spacing: 4) {
                        Text ( feast.title )
                            .font ( .system ( size: 18, weight: .semibold, design: .serif ) )
                            .foregroundStyle ( .primary )
                            .multilineTextAlignment ( .leading )
                        
                        ForEach(feast.commemorations) { commemoration in
                            Text("Commemoration: \(commemoration.title)")
                                .font(.system(size: 13, design: .serif))
                                .foregroundStyle(.secondary)
                                .italic()
                                .multilineTextAlignment(.leading)
                        }
                    }
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
                .background ( .clear )
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

struct OrdoEventList: View {
    @Environment(ActiveData.self) var activeData
    @Binding var search: String
    @Binding var year: Int
    @Binding var searchIsActive: Bool
    
    @State private var searchResults: [ [ OrdoDay ] ] = []
    @State private var flatSearchResults: [ OrdoDay ] = []

    private var isCurrentYear: Bool { year == CurrentYear ( ) }

    private var today: OrdoDay? {
        guard isCurrentYear, search.isEmpty, !searchIsActive else { return nil }
        return activeData.GetYear ( year: year )?.getDay ( month: CurrentMonth ( ), day: CurrentDay ( ) )
    }

    var body: some View {
        List {
            if let todayDay = today {
                TodayCard ( day: todayDay )
                    .id ( "today-card" )
                    .listRowInsets ( EdgeInsets ( ) )
                    .listRowBackground ( Color.clear )
                    .listRowSeparator ( .hidden )
            }
            
            if search.isEmpty {
                ForEach ( searchResults, id: \.self ) { month in
                    Section ( header: Text ( month.first?.date.month.uppercased ( ) ?? "" )
                        .font ( .system ( size: 14, weight: .bold, design: .serif ) )
                        .foregroundStyle ( .red )
                        .padding ( .top, 10 )
                    ) {
                        ForEach ( month ) { day in
                            NavigationLink {
                                DisplayPropers ( celebrations: day.celebrations.filter { $0.propers.count > 0 } )
                            } label: {
                                OrdoRow ( feast: day, year: String ( self.year ) )
                            }
                            .id ( day.date.combined )
                            .padding ( [ .vertical ], 8 )
                        }
                    }
                    .id ( month.first?.date.month ?? "" )
                }
            } else {
                Section ( header: Text ( "SEARCH RESULTS" )
                    .font ( .system ( size: 12, weight: .bold, design: .serif ) )
                    .foregroundStyle ( .red )
                ) {
                    ForEach ( flatSearchResults ) { day in
                        NavigationLink {
                            DisplayPropers ( celebrations: day.celebrations.filter { $0.propers.count > 0 } )
                        } label: {
                            OrdoRow ( feast: day, year: String ( self.year ) )
                        }
                        .id ( day.date.combined )
                        .padding ( [ .vertical ], 8 )
                    }
                }
            }
        }
            .listSectionSpacing ( .compact )
            .overlay {
                if self.flatSearchResults.isEmpty, !self.search.isEmpty {
                    ContentUnavailableView.search ( text: self.search )
                }
            }
            .onChange ( of: searchIsActive ) { _, active in
                if !active {
                    searchResults = activeData.GetYear ( year: year )?.ordo ?? []
                    flatSearchResults = []
                }
            }
            .task ( id: search ) {
                if search.isEmpty {
                    searchResults = activeData.GetYear ( year: year )?.ordo ?? []
                    flatSearchResults = []
                    return
                }
                
                guard let snapshot = activeData.getSearchSnapshot ( year: year ) else { return }
                let queryWords = search.lowercased ( ).components ( separatedBy: .whitespacesAndNewlines ).filter { !$0.isEmpty }
                
                let filtered: [ OrdoDay ] = await Task.detached ( priority: .userInitiated ) {
                    var result: [ OrdoDay ] = []
                    for entry in snapshot.entries {
                        let matchesAll = queryWords.allSatisfy { entry.text.contains ( $0 ) }
                        if matchesAll {
                            let day = snapshot.months [ entry.month ] [ entry.day ]
                            result.append ( day )
                        }
                    }
                    return result
                }.value
                
                guard !Task.isCancelled else { return }
                flatSearchResults = filtered
            }
            .task ( id: year ) {
                searchResults = activeData.GetYear ( year: year )?.ordo ?? []
                flatSearchResults = []
            }
    }
}
