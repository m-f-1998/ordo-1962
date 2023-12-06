//
//  FirebaseConfig.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 27/04/2023.
//

import SwiftUI

let config: AppConfig = AppConfig ( ) // Singelton

// Get configuration From Firebase
class AppConfig {

    var settings: AppSettings!

    func GetSettings ( ) async {
        guard let address: URL = URL ( string: "https://matthewfrankland.co.uk/ordo-1962/settings" ) else {
            print ( "ERROR: Settings Could Not Be Fetched" )
            return
        }

        let url_request: URLRequest = URLRequest ( url: address )

        do {
            let ( data, response ) = try await URLSession.shared.data ( for: url_request )
            let status_code: Int? = ( response as? HTTPURLResponse )?.statusCode
            
            guard status_code == 200 else {
                print ( "1 HTTP Status Code \(status_code ?? -1)" )
                return
            }

            self.settings = try JSONDecoder ( ).decode ( AppSettings.self, from: data )
        } catch {
            print ( "URLSession didnt work" )
        }
    }

    // An Update To The Client Is Available On The App Store
    func UpdateAvailable ( ) -> Binding<Bool> {
        let latest_version: Double = self.settings == nil ? 0.0 : self.settings.latest_version
        let current_version = ( Bundle.main.infoDictionary? [ "CFBundleShortVersionString" ] as! String ).components ( separatedBy: "." )
        return .constant ( Double ( "\(current_version [ 0 ]).\(current_version [ 1 ] )" ) ?? .infinity < latest_version )
    }
    
    // Data From API Is Stale - Delete Cache
    func DataStale ( ) -> Bool {
        let last_fetch = UserDefaults.standard.string ( forKey: "last-update" )
        if !( last_fetch ?? "" ).isEmpty {
            let api_update = self.settings == nil ? Date.distantPast as NSDate : NSDate ( timeIntervalSince1970: TimeInterval ( self.settings.api_updated ) )
            return ( api_update as Date ) > FormatDate ( time: true ).date ( from: last_fetch! )!
        }
        return false
    }
}
