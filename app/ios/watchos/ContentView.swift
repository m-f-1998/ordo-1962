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
        VStack ( alignment: .leading, spacing: 6 ) {
            // Sleek Header: Date info
            HStack {
                Text ( day.date.combined.uppercased ( ) )
                    .font ( .system ( size: 10, weight: .bold, design: .serif ) )
                    .foregroundStyle ( Color ( red: 0.65, green: 0.08, blue: 0.08 ) )
                    .tracking ( 1.2 )
                
                Spacer ( )
            }
            .padding ( .top, 8 )
            .padding ( .horizontal, 10 )
            
            Divider ( )
                .background ( Color ( red: 0.65, green: 0.08, blue: 0.08 ).opacity ( 0.15 ) )
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
                        .foregroundStyle ( .secondary )
                }
                .padding ( .horizontal, 10 )
                .padding ( .bottom, 8 )
            }
        }
        .frame ( maxWidth: .infinity, alignment: .leading )
        .background ( Color.white.opacity ( 0.1 ) )
        .clipShape ( RoundedRectangle ( cornerRadius: 12 ) )
        .padding ( .vertical, 4 )
    }
}

struct WatchOrdoList: View {
    let ordo: [ OrdoDay ]

    var body: some View {
        ScrollView ( .vertical, showsIndicators: false ) {
            LazyVStack ( spacing: 8 ) {
                ForEach ( ordo, id: \.id ) { day in
                    WatchOrdoRow ( day: day )
                }
            }
        }
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
            if try api.cache.CacheExists ( predicate: #Predicate<OrdoYear> { _ in true } ) {
                let ordo = try api.cache.GetOrdo ( predicate: #Predicate<OrdoYear> { _ in true } )
                activeData.SetSuccess ( ordo: ordo, locale: try api.cache.GetLocale ( ), prayers: nil, votives: nil )
            } else {
                Task {
                    do {
                        try await api.UpdateCache ( )
                        let ordo = try api.cache.GetOrdo ( predicate: #Predicate<OrdoYear> { _ in true } )
                        activeData.SetSuccess ( ordo: ordo, locale: try api.cache.GetLocale ( ), prayers: nil, votives: nil )
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
