//
//  PropersAPI.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import Foundation

class PropersAPI: ObservableObject {
    private let file: String = "propers.data", url = "propers.php"
    @Published private ( set ) var res: ResultAPI <PropersData>!
    private var api: API = API ( )

    init ( ) {
        self.res = self.GetCache ( )
    }

    // Update The Status Of The Ordo Calendar Data
    func Update ( use_cache: Bool = true ) async {
        if use_cache {
            if case .success ( _ ) = self.res {
                print ( "Propers Data Already At Status Successful" )
                return
            }
        }
        let queries = [
            URLQueryItem ( name: "year", value: UserDefaults.standard.string ( forKey: "year" ) ?? CurrentYear ( ) )
        ]

        let data = await self.api.GetAPI ( file: self.file, url: self.url, type: PropersData.self, queries: queries )
        DispatchQueue.main.async {
            self.res = data
        }
    }
    
    // Go Back To Current Year
    func BackToCurrentYear ( ) {
        self.res = self.GetCache ( )
    }
    
    // Get Cache Data, Ignore Internet
    func GetCache ( ) -> ResultAPI <PropersData> {
        do {
            return .success ( try self.api.GetCache ( file: self.file, type: PropersData.self ) )
        } catch ErrorAPI.fetching {
            UserDefaults.standard.set ( 1, forKey: "go-to-today" )
            return .loading ( [ : ] )
        } catch {
            return .failure ( error.localizedDescription )
        }
    }

}
