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
    @Published private ( set ) var res: ResultAPI = .loading

    // Get Data From Local Device Or From API
    func GetData ( ) async {
        do {
            if false && self.CacheExists ( ) && CurrentDay ( ) != 1 && CurrentMonth ( ) != "January" {
                let ordo: OrdoData = try self.Decode ( data: Data ( contentsOf: self.GetURL ( ) ), type: OrdoData.self ),
                cal: Calendar = .current, next_month = cal.monthSymbols [ cal.component ( .month, from: .now ) ],
                months_to_show: [ CelebrationData ] =  ordo [ CurrentMonth ( ) ]! + ordo [ next_month ]!
                
                DispatchQueue.main.async {
                    self.res = .success ( Array ( months_to_show [ CurrentDay ( ) - 1...CurrentDay ( ) + 5 ] ) )
                }
            }
            let data = try self.Decode ( data: try await self.HTTP ( ), type: [ CelebrationData ].self )
            DispatchQueue.main.async {
                self.res = .success ( data )
            }
        } catch ErrorAPI.fetching ( let message ) {
            DispatchQueue.main.async {
                self.res = .failure ( message )
            }
        } catch {
            DispatchQueue.main.async {
                self.res = .failure ( "An Unkown Error Occured" )
            }
        }
    }
    
    // Cache data in document directory
    private func GetURL ( ) throws -> URL {
        let container = self.manager.containerURL ( forSecurityApplicationGroupIdentifier: "group.mfrankland.ordo-62.contents" )!
        return container.appendingPathComponent ( "ordo.data" )
    }

    // Check Cache File Exists
    private func CacheExists ( ) -> Bool {
        do {
            return self.manager.fileExists ( atPath: try self.GetURL ( ).path ( ) )
        } catch {
            return false
        }
    }

    // Decode Into JSON Format
    private func Decode <T:Decodable> ( data: Data, type: T.Type ) throws -> T {
        return try JSONDecoder ( ).decode ( T.self, from: data )
    }

    // Run a URL Request To API
    private func HTTP ( ) async throws -> Data {
        guard let address = URL ( string: "https://matthewfrankland.co.uk/ordo-1962/ordo.php" ) else { throw ErrorAPI.fetching ( "URL Undefined" ) }

        var url_request = URLRequest ( url: address )
        url_request.httpMethod = "POST"
        url_request.setValue ( "application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type" )
        url_request.setValue ( "application/json", forHTTPHeaderField: "Accept" )

        let ( data, response ) = try await URLSession.shared.data ( for: url_request )
        let status_code: Int? = ( response as? HTTPURLResponse )?.statusCode

        guard status_code == 200 else { throw ErrorAPI.fetching ( "HTTP Status Code \(status_code ?? -1)" ) }

        return data
    }
}
