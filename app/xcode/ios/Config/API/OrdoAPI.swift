//
//  OrdoAPI.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 02/07/2023.
//

import Foundation

class OrdoAPI: ObservableObject {
    private let file: String = "ordo.data", url = "ordo.php"
    @Published private ( set ) var res: ResultAPI <OrdoData> = .loading ( DUMMY_ORDO )
    private var api: API = API ( )

    // Update The Status Of The Ordo Calendar Data
    func Update ( ignore_cache: Bool = false ) async {
        let now: String = FormatDate ( time: true ).string ( from: .now )
        UserDefaults.standard.set ( now, forKey: "lastUpdate" )

        let new_year = CurrentDay ( ) == 1 && CurrentMonth ( ) == "January"
        let queries = [
            URLQueryItem ( name: "year", value: UserDefaults.standard.string ( forKey: "year" ) ?? "2023" ),
            URLQueryItem ( name: "timezone", value: TimeZone.current.abbreviation ( ) )
        ]

        let data = await api.GetData ( ignore_cache: ignore_cache, new_year: new_year, wait: true, file: file, url: url, type: OrdoData.self, queries: queries )
        DispatchQueue.main.async { self.res = data }
    }
    
    // Reset Ordo to Progress View
    func SetLoading ( ) {
        res = .loading ( DUMMY_ORDO )
    }
}
