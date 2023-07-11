//
//  PropersAPI.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import Foundation

class PropersAPI: ObservableObject {
    private let file: String = "propers.data", url = "propers.php"
    @Published private ( set ) var res: ResultAPI <PropersData> = .loading ( [ : ] )
    private var api: API = API ( )

    // Update The Status Of The Ordo Calendar Data
    func Update ( ignore_cache: Bool = false ) async {
        let new_year = CurrentDay ( ) == 1 && CurrentMonth ( ) == "January"
        let queries = [
            URLQueryItem ( name: "year", value: UserDefaults.standard.string ( forKey: "year" ) ?? "2023" )
        ]

        let data = await api.GetData ( ignore_cache: ignore_cache, new_year: new_year, wait: true, file: file, url: url, type: PropersData.self, queries: queries )
        DispatchQueue.main.async { self.res = data }
    }
    
    // Reset Ordo to Progress View
    func SetLoading ( ) {
        res = .loading ( [ : ] )
    }
}
