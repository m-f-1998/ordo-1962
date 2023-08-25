//
//  AppDelegate.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 23/04/2023.
//

import UIKit
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application ( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [ UIApplication.LaunchOptionsKey : Any ]? = nil ) -> Bool {        
        // FCM Config
        FirebaseConfiguration.shared.setLoggerLevel ( .min )
        FirebaseApp.configure ( )
        
        return true
    }

    // Tells the delegate when the app is about to terminate.
    // iOS 2+
    func applicationWillTerminate ( _ application: UIApplication ) {
        UserDefaults.standard.set ( 1, forKey: "go-to-today" )
    }
}
