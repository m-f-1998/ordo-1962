//
//  FirebaseConfig.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 27/04/2023.
//

import SwiftUI
import FirebaseRemoteConfig

let config: FirebaseConfig = FirebaseConfig ( ) // Singelton

// Get configuration From Firebase
class FirebaseConfig {
    private var config: RemoteConfig = RemoteConfig.remoteConfig ( )
    private var api_update_time: Date = .now // Time of last update
    private var latest_app_version: Double = 0.0 // Up-to-date app version, to notify of updates

    init ( ) {
        #if DEBUG
            /*
             A lower 'minimumFetchInterval' refreshes the cache more times per hour to allow rapid iteration of development builds. Real-time Remote Config bypass the cache when the config is updated on the server.
             The default and recommended production fetch interval for Remote Config is 12 hours, which means that configs won't be fetched from the backend more than once in a 12 hour window, regardless of how many fetch calls are actually made.
             */
            let settings = RemoteConfigSettings ( )
            settings.minimumFetchInterval = 0
            self.config.configSettings = settings
        #endif
        
        self.config.fetchAndActivate ( )

        self.latest_app_version = self.config.configValue ( forKey: "app_version" ).numberValue.doubleValue
        self.api_update_time = FormatDate ( time: true ).date ( from: self.config.configValue ( forKey: "last_data_update" ).stringValue! ) ?? .now
    }

    // An Update To The Client Is Available On The App Store
    func UpdateAvailable ( ) -> Binding<Bool> {
        let current_version = Bundle.main.infoDictionary? [ "CFBundleShortVersionString" ] as! String
        return .constant ( Double ( current_version ) ?? 0.0 < self.latest_app_version )
    }
    
    // Data From API Is Stale - Delete Cache
    func DataStale ( ) -> Bool { // Is cached data up to date?
        let last_api_fetch = UserDefaults.standard.string ( forKey: "last-update" )
        if ( last_api_fetch != nil ) {
            return self.api_update_time > FormatDate ( time: true ).date ( from: last_api_fetch! )!
        }
        return false
    }
}
