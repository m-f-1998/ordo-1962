//
//  API.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 23/04/2023.
//

import SwiftUI

class API {
    @ObservedObject private var net: NetworkMonitor = NetworkMonitor ( )

    // Get Data From Local Device Or From API
    func GetAPI <T:Decodable> ( use_cache: Bool = false, file: String, url: String, type: T.Type, queries: [ URLQueryItem ] = [ ] ) async -> ResultAPI <T> {
        do {
            if use_cache {
                do {
                    return try .success ( self.GetCache ( file: file, type: type ) )
                } catch { }
            }
            if self.net.connected {
                return .success ( try await self.SaveCache ( url: url, file: file, type: T.self, url_query: queries ) )
            }
            return .failure ( "Update Could Not Be Fetched" )
        } catch ErrorAPI.fetching ( let message ) {
            return .failure ( message )
        } catch ErrorAPI.saving {
            return .failure ( "An Unknown Error Occured While Saving" )
        } catch {
            return .failure ( "An Unknown Error Occured" )
        }
    }
    
    // Retrieve Cache Data
    func GetCache <T:Decodable> ( file: String, type: T.Type ) throws -> T {
        if self.CacheExists ( name: file ) {
            return try self.Decode ( data: Data ( contentsOf: self.GetURL ( file_name: file ) ), type: type )
        }
        throw ErrorAPI.fetching ( "Cache Data Could Not Be Retrieved" )
    }

    // Cache data in document directory
    func GetURL ( file_name: String ) throws -> URL {
        let container = FileManager.default.containerURL ( forSecurityApplicationGroupIdentifier: "group.mfrankland.ordo-62.contents" )!
        return container.appending ( path: file_name, directoryHint: .notDirectory )
    }
    
    // Check Cache File Exists
    func CacheExists ( name: String ) -> Bool {
        do {
            return FileManager.default.fileExists ( atPath: try self.GetURL ( file_name: name ).path ( ) )
        } catch {
            return false
        }
    }

    // Save a cache file which is accessible only while the device is unlocked
    private func SaveCache <T:Decodable> ( url: String, file: String, type: T.Type, url_query: [ URLQueryItem ] ) async throws -> T {
        do {
            let data = try await self.HTTP ( url: url, request_params: url_query )
            print ( "Writing New Cache for \(file)" )
            try data.write ( to: self.GetURL ( file_name: file ), options: .completeFileProtection )
            return try self.Decode ( data: data, type: T.self )
        } catch {
            print ( error )
            throw ErrorAPI.saving
        }
    }
    
    // Decode Into JSON Format
    private func Decode <T:Decodable> ( data: Data, type: T.Type ) throws -> T {
        return try JSONDecoder ( ).decode ( T.self, from: data )
    }

    // Run a URL Request To API
    private func HTTP ( url: String, request_params: [ URLQueryItem ] ) async throws -> Data {
        guard let address: URL = URL ( string: "https://matthewfrankland.co.uk/ordo-1962/v1.2/\(url)" ) else { throw ErrorAPI.fetching ( "URL Invalid" ) }

        var url_request: URLRequest = URLRequest ( url: address )
        url_request.httpMethod = "POST"
        url_request.setValue ( "application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type" )
        url_request.setValue ( "application/json", forHTTPHeaderField: "Accept" )

        var body: URLComponents = URLComponents ( )
        body.queryItems = request_params
        url_request.httpBody = body.query?.data ( using: .utf8 )

        let ( data, response ) = try await URLSession.shared.data ( for: url_request )
        let status_code: Int? = ( response as? HTTPURLResponse )?.statusCode

        guard status_code == 200 else { throw ErrorAPI.fetching ( "HTTP Status Code \(status_code ?? -1)" ) }
        return data
    }
}
