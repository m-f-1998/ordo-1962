//
//  ContentView.swift
//  ordo-1962-watch
//
//  Created by Matthew Frankland on 11/06/2023.
//

import SwiftUI

struct WatchOrdoRow: View {
    let day: OrdoDay

    private var theme: LiturgicalTheme { LiturgicalTheme ( day: day ) }

    var body: some View {
        VStack ( alignment: .leading, spacing: 4 ) {
            // Sleek Header: Date info
            HStack {
                Text ( day.date.combined.uppercased ( ) )
                    .font ( .system ( size: 10, weight: .bold, design: .serif ) )
                    .foregroundStyle ( theme.accent )
                    .tracking ( 1.2 )
                
                Spacer ( )
            }
            .padding ( .top, 8 )
            .padding ( .horizontal, 10 )
            
            Divider ( )
                .background ( theme.accent.opacity ( 0.25 ) )
                .padding ( .horizontal, 10 )
            
            ForEach ( day.celebrations, id: \.id ) { celebration in
                VStack ( alignment: .leading, spacing: 2 ) {
                    Text ( celebration.title )
                        .font ( .system ( size: 13, weight: .semibold, design: .serif ) )
                        .foregroundStyle ( .primary )
                        .minimumScaleFactor ( 0.8 )
                        .lineLimit ( 3 )
                    Text ( "CLASS \(celebration.rank)" )
                        .font ( .system ( size: 9, weight: .bold, design: .serif ) )
                        .foregroundStyle ( theme.accent )
                }
                .padding ( .horizontal, 10 )
                .padding ( .bottom, 8 )
            }
        }
        .frame ( maxWidth: .infinity, alignment: .leading )
        .background ( theme.accentSubtle )
        .clipShape ( RoundedRectangle ( cornerRadius: 10, style: .continuous ) )
        .padding ( .vertical, 2 )
    }
}

struct WatchOrdoList: View {
    let ordo: [ OrdoDay ]

    var body: some View {
        ScrollView ( .vertical, showsIndicators: false ) {
            LazyVStack ( spacing: 6 ) {
                ForEach ( ordo, id: \.id ) { day in
                    NavigationLink ( destination: WatchDisplayPropers ( celebrations: day.celebrations ) ) {
                        WatchOrdoRow ( day: day )
                    }
                    .buttonStyle ( .plain )
                }
            }
            .padding ( .horizontal, 4 )
        }
    }
}

struct WatchErrorView: View {
    let message: String
    let retryAction: ( ) async -> Void

    var body: some View {
        VStack ( spacing: 12 ) {
            Image ( systemName: "exclamationmark.triangle" )
                .font ( .title2 )
                .foregroundStyle ( .yellow )
            Text ( message )
                .font ( .caption )
                .multilineTextAlignment ( .center )
            Button {
                Task {
                    await retryAction ( )
                }
            } label: {
                Label ( "Retry", systemImage: "arrow.clockwise" )
            }
            .buttonStyle ( .borderedProminent )
        }
        .padding ( )
    }
}

struct ContentView: View {
    @State private var activeData: ActiveData
    @State private var api: API

    init ( ) {
        let activeData = ActiveData ( )
        _activeData = State ( initialValue: activeData )
        _api = State ( initialValue: API ( activeData: activeData ) )
    }

    var body: some View {
        Group {
            if activeData.loading {
                VStack ( spacing: 8 ) {
                    ProgressView ( )
                    Text ( "Loading…" )
                        .font ( .caption )
                        .foregroundStyle ( .secondary )
                }
                .task { await loadData ( ) }
            } else if activeData.error {
                WatchErrorView ( message: activeData.last_err, retryAction: { await loadData ( ) } )
            } else if activeData.GetYear ( ) != nil {
                NavigationStack {
                    WatchOrdoList ( ordo: getTwoWeeksDays ( ) )
                }
            } else {
                WatchErrorView ( message: "No data available", retryAction: { await loadData ( ) } )
            }
        }
    }

    private func getTwoWeeksDays ( ) -> [ OrdoDay ] {
        var days: [ OrdoDay ] = [ ]
        let calendar = Calendar.current
        for i in 0..<14 {
            if let date = calendar.date ( byAdding: .day, value: i, to: .now ) {
                let yr = calendar.component ( .year, from: date )
                let monthIdx = calendar.component ( .month, from: date ) - 1
                let shortMonth = calendar.shortMonthSymbols [ monthIdx ]
                let dy = calendar.component ( .day, from: date )
                
                if let ordoYear = activeData.GetYear ( year: yr ) {
                    let ordoDay = ordoYear.getDay ( month: shortMonth, day: dy )
                    days.append ( ordoDay )
                }
            }
        }
        return days
    }

    private func loadData ( ) async {
        do {
            // Determine the years spanned by the next 14 days (usually 1 year, sometimes 2)
            let calendar = Calendar.current
            var yearsToLoad = Set<Int> ( )
            for i in 0..<14 {
                if let date = calendar.date ( byAdding: .day, value: i, to: .now ) {
                    let yr = calendar.component ( .year, from: date )
                    yearsToLoad.insert ( yr )
                }
            }
            
            // Load the required years directly from the bundle via API
            // (Skipped here since ActiveData.GetYear loads on demand)
            
            // Fetch the locale directly from the bundle via API
            let locale = try await api.LocaleRequest ( )

            // Populate activeData with only the loaded years and locale!
            activeData.SetSuccess ( ordo: [], locale: locale, prayers: nil, votives: nil )
        } catch {
            activeData.SetError ( error: "Could not load data: \(error.localizedDescription)" )
        }
    }
}
