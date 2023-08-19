//
//  API.swift
//  ordo-1962-watch
//
//  Created by Matthew Frankland on 23/06/2023.
//

import SwiftUI

enum ResultAPI: Equatable {
    case loading, success ( [ CelebrationData ] ), failure ( String )
}

enum ErrorAPI: Error {
    case fetching ( String )
}

class API: ObservableObject {
    private let manager: FileManager = FileManager.default
    @Published private ( set ) var res: ResultAPI!
    
    init ( ) {
        do {
            self.res = .success ( try self.GetCache ( ) )
        } catch ErrorAPI.fetching {
            self.res = .loading
        } catch {
            self.res = .failure ( error.localizedDescription )
        }
    }

    // Get Data From API
    func GetData ( ) async {
        do {
            do {
                let cache = try self.GetCache ( )
                DispatchQueue.main.async {
                    self.res = .success ( cache )
                }
            } catch {
                print ( "Cache Could Not Be Used" )
                let http = try await self.HTTP ( )
                DispatchQueue.main.async {
                    self.res = .success ( http )
                }
            }
        } catch ErrorAPI.fetching ( let message ) {
            DispatchQueue.main.async {
                self.res = .failure ( message )
            }
        } catch {
            print ( error.localizedDescription )
            DispatchQueue.main.async {
                self.res = .failure ( "The Operation Could Not Be Completed" )
            }
        }
    }
    
    // Reduce Data to a Week of Celebrations
    func GetCelebrations ( data: Data ) throws -> [ CelebrationData ] {
        let next_month: String = Calendar.current.monthSymbols [ Calendar.current.component ( .month, from: .now ) ]
        do {
            let ordo: OrdoData = try self.Decode ( data: data, type: OrdoData.self )
            let months_to_show: [ CelebrationData ] = ordo [ CurrentMonth ( ) ]! + ordo [ next_month ]!
            return Array ( months_to_show [ CurrentDay ( ) - 1...CurrentDay ( ) + 5 ] )
        } catch {
            throw ErrorAPI.fetching ( "An error occured reducing data to celebrations \(error)" )
        }
    }

    // Get Data From Local Device
    func GetCache ( ) throws -> [ CelebrationData ] {
        if self.CacheExists ( ) {
            return try self.GetCelebrations ( data: Data ( contentsOf: self.GetURL ( ) ) )
        }
        throw ErrorAPI.fetching ( "Cache data was not found" )
    }

    // Cache data in document directory
    private func GetURL ( ) throws -> URL {
        #if os(watchOS)
            let container = try self.manager.url ( for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false )
        #else
            let container = self.manager.containerURL ( forSecurityApplicationGroupIdentifier: "group.mfrankland.ordo-62.contents" )!
        #endif
        return container.appending ( path: "ordo.data", directoryHint: .notDirectory )
    }

    // Check Cache File Exists
    private func CacheExists ( ) -> Bool {
        do {
            return try CurrentDay ( ) != 1 && CurrentMonth ( ) != "January" && self.manager.fileExists ( atPath: self.GetURL ( ).path ( ) )
        } catch {
            return false
        }
    }

    // Decode Into JSON Format
    private func Decode <T:Decodable> ( data: Data, type: T.Type ) throws -> T {
        #if os(watchOS)
            try data.write ( to: self.GetURL ( ), options: .completeFileProtection )
        #endif
        return try JSONDecoder ( ).decode ( T.self, from: data )
    }

    // Run a URL Request To API
    private func HTTP ( ) async throws -> [ CelebrationData ] {
        guard let address = URL ( string: "https://matthewfrankland.co.uk/ordo-1962/v1.1.1/ordo.php" ) else { throw ErrorAPI.fetching ( "URL Undefined" ) }

        var url_request = URLRequest ( url: address )
        url_request.httpMethod = "POST"
        url_request.setValue ( "application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type" )
        url_request.setValue ( "application/json", forHTTPHeaderField: "Accept" )

        var body: URLComponents = URLComponents ( )
        body.queryItems = [
            URLQueryItem ( name: "year", value: CurrentYear ( ) )
        ]
        url_request.httpBody = body.query?.data ( using: .utf8 )

        let ( data, response ) = try await URLSession.shared.data ( for: url_request )
        let status_code: Int? = ( response as? HTTPURLResponse )?.statusCode

        guard status_code == 200 else { throw ErrorAPI.fetching ( "HTTP Status Code \(status_code ?? -1)" ) }

        return try self.GetCelebrations ( data: data )
    }
}
