//
//  API.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 23/04/2023.
//

import SwiftUI
import FirebaseAuth

class API {
    private let manager: FileManager = FileManager.default
    private let config: FirebaseConfig = FirebaseConfig ( )
    @ObservedObject private var net: NetworkMonitor = NetworkMonitor ( )

    // Get Data From Local Device Or From API
    func GetData <T:Decodable> ( ignore_cache: Bool = false, just_cache: Bool = false, new_year: Bool = false, wait: Bool, file: String, url: String, type: T.Type, queries: [ URLQueryItem ] = [ ] ) async -> ResultAPI <T> {
        do {
            if !ignore_cache && UseCache ( is_new_year: new_year, only_cache: just_cache ) {
                if ( wait ) {
                    try await Task.sleep ( nanoseconds: UInt64 ( 1 * Double ( NSEC_PER_SEC ) ) )
                }
                if self.CacheExists ( name: file ) {
                    return try .success ( self.Decode ( data: Data ( contentsOf: self.GetURL ( file_name: file ) ), type: type.self ) )
                }
            }
            if !just_cache && self.net.connected {
                return .success ( try await self.SaveCache ( url: url, file: file, type: T.self, url_query: queries ) )
            }
            return .failure ( "Data Could Not Be Fetched" )
        } catch ErrorAPI.fetching ( let message ) {
            return .failure ( message )
        } catch ErrorAPI.saving {
            return .failure ( "An Unkown Error Occured While Saving" )
        } catch {
            return .failure ( "An Unkown Error Occured" )
        }
    }

    // Cache data in document directory
    private func GetURL ( file_name: String ) throws -> URL {
        let container = self.manager.containerURL ( forSecurityApplicationGroupIdentifier: "group.mfrankland.ordo-62.contents" )!
        return container.appendingPathComponent ( file_name )
    }
    
    // Check If Cache Should Be Used
    private func UseCache ( is_new_year: Bool, only_cache: Bool ) -> Bool {
        if only_cache {
            return !is_new_year
        }
        return !is_new_year && !( self.net.connected && self.config.DataStale ( ) )
    }
    
    // Check Cache File Exists
    private func CacheExists ( name: String ) -> Bool {
        do {
            return self.manager.fileExists ( atPath: try self.GetURL ( file_name: name ).path ( ) )
        } catch {
            return false
        }
    }

    // Decode Into JSON Format
    private func Decode <T:Decodable> ( data: Data, type: T.Type ) throws -> T {
        return try JSONDecoder ( ).decode ( T.self, from: data )
    }

    // Save a cache file which is accessible only while the device is unlocked
    private func SaveCache <T:Decodable> ( url: String, file: String, type: T.Type, url_query: [ URLQueryItem ] ) async throws -> T {
        do {
            let year: String = UserDefaults.standard.string ( forKey: "year" ) ?? "2023"
            let data = try await self.HTTP ( url: url, request_params: url_query )
            if year == CurrentYear ( ) {
                try data.write ( to: self.GetURL ( file_name: file ), options: .completeFileProtection )
            }
            return try self.Decode ( data: data, type: T.self )
        } catch {
            print ( String ( describing: error ) )
            throw ErrorAPI.saving
        }
    }

    // Run a URL Request To API
    private func HTTP ( url: String, request_params: [ URLQueryItem ] ) async throws -> Data {
        guard let address: URL = URL ( string: "https://matthewfrankland.co.uk/ordo-1962/\(url)" ) else { throw ErrorAPI.fetching ( "URL Invalid" ) }

        var url_request: URLRequest = URLRequest ( url: address )
        url_request.httpMethod = "POST"
        url_request.setValue ( "application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type" )
        url_request.setValue ( "application/json", forHTTPHeaderField: "Accept" )

        var body: URLComponents = URLComponents ( )
        let default_params = [
            URLQueryItem ( name: "user_id", value: try await Auth.auth ( ).signInAnonymously ( ).user.uid )
        ]
        body.queryItems = request_params + default_params
        url_request.httpBody = body.query?.data ( using: .utf8 )

        let ( data, response ) = try await URLSession.shared.data ( for: url_request )
        let status_code: Int? = ( response as? HTTPURLResponse )?.statusCode
        
        if status_code == 401 {
            try Auth.auth ( ).signOut ( )
            return try await HTTP ( url: url, request_params: request_params )
        }

        guard status_code == 200 else { throw ErrorAPI.fetching ( "HTTP Status Code \(status_code ?? -1)" ) }
        return data
    }
}
