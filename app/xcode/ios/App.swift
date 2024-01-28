//
//  App.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 18/04/2023.
//

import SwiftUI

@main
struct OrdoiOS: App {
    @ObservedObject var net: NetworkMonitor = NetworkMonitor ( )
    @ObservedObject var activeData: ActiveData
    @ObservedObject var tabStateHanlder: TabStateHandler = TabStateHandler ( )
    @State var api: API
    
    init ( ) {
        let activeData = ActiveData ( )
        self.activeData = activeData
        self.api = API ( activeData: activeData )
    }

    var body: some Scene {
        WindowGroup {
            ContentView ( api: api )
        }
        .environmentObject ( self.activeData )
        .environmentObject ( self.tabStateHanlder )
        .modelContainer ( self.api.cache.GetContainer ( ) )
    }
}
