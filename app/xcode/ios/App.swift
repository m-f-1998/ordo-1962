//
//  App.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 18/04/2023.
//

import SwiftUI
import BackgroundTasks

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
//        registerBackgroundTask()
    }

//    private func registerBackgroundTask() {
//        BGTaskScheduler.shared.register ( forTaskWithIdentifier: "com.mfrankland.ordo-62", using: nil ) { task in
//            handleBackgroundTask ( task: task as! BGProcessingTask )
//        }
//    }

    var body: some Scene {
        WindowGroup {
            ContentView ( api: api )
        }
        .environmentObject ( self.activeData )
        .environmentObject ( self.tabStateHanlder )
        .modelContainer ( self.api.cache.GetContainer ( ) )
    }
    
//    private func handleBackgroundTask(task: BGProcessingTask) {
//        // Your background task logic
//        task.setTaskCompleted(success: true)
//    }
}
