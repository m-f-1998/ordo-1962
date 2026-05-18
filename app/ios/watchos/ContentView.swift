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
            Text ( day.date.combined )
                .font ( .system ( .caption2, design: .serif ) )
                .foregroundStyle ( theme.accent )
            ForEach ( day.celebrations, id: \.id ) { celebration in
                Text ( celebration.title )
                    .font ( .system ( .body, design: .serif ) )
                    .fontWeight ( .semibold )
                Text ( "Class \(celebration.rank)" )
                    .font ( .caption2 )
                    .foregroundStyle ( .secondary )
            }
        }
        .padding ( .vertical, 4 )
    }
}

struct WatchOrdoList: View {
    let ordo: [ OrdoDay ]

    var body: some View {
        List ( ordo, id: \.id ) { day in
            WatchOrdoRow ( day: day )
        }
        .listStyle ( .carousel )
    }
}

struct WatchErrorView: View {
    let message: String
    let api: API

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
                    do {
                        try await api.UpdateCache ( )
                    } catch {
                        print ( "Cache update failed: \(error)" )
                    }
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
                .onAppear { loadData ( ) }
            } else if activeData.error {
                WatchErrorView ( message: activeData.last_err, api: api )
            } else if let year = activeData.GetYear ( ) {
                WatchOrdoList ( ordo: year.getMonth ( month: CurrentMonth ( ) ) )
            } else {
                WatchErrorView ( message: "No data available", api: api )
            }
        }
    }

    private func loadData ( ) {
        do {
            if try api.cache.CurrentCacheExists ( predicate: #Predicate<OrdoYear> { _ in true } ) {
                let ordo = try api.cache.GetOrdo ( predicate: #Predicate<OrdoYear> { _ in true } )
                activeData.SetSuccess ( ordo: ordo, locale: try api.cache.GetLocale ( ), prayers: nil, votives: nil )
            } else {
                Task {
                    do {
                        let year = try await api.GetCurrent ( )
                        activeData.SetSuccess ( ordo: [ year ], locale: try api.cache.GetLocale ( ), prayers: nil, votives: nil )
                    } catch {
                        activeData.SetError ( error: "Could not load data" )
                    }
                }
            }
        } catch {
            activeData.SetError ( error: "Could not load data" )
        }
    }
}
