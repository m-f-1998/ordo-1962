//
//  App.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 18/04/2023.
//

import SwiftUI

@main
struct OrdoiOS: App {
    @State private var activeData: ActiveData
    @State private var api: API
    @State private var tabStateHandler = TabStateHandler ( )
    let net = NetworkMonitor ( )

    init ( ) {
        let activeData = ActiveData ( )
        _activeData = State ( initialValue: activeData )
        _api = State ( initialValue: API ( activeData: activeData ) )
    }

    var body: some Scene {
        WindowGroup {
            ContentView ( api: api )
        }
        .environment ( activeData )
        .environment ( tabStateHandler )
        .environment ( net )
        .modelContainer ( api.cache.GetContainer ( ) )
    }
}
