//
//  PrayersAPI.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 02/07/2023.
//

import Foundation
import FirebaseAuth

class PrayerAPI: ObservableObject {
    private let file: String = "prayer.data", url = "prayers.php"
    @Published private ( set ) var res: ResultAPI <PrayerCategoryData> = .loading ( [ : ] )
    private var api: API
    
    init ( config: FirebaseConfig ) {
        self.api = API ( config: config )
    }

    // Update The Status Of The Sheet Containing Prayers
    func Update ( ignore_cache: Bool = false, lang: String ) async {
        let queries = [
            URLQueryItem ( name: "lang", value: lang )
        ]

        let data =  await self.api.GetData ( ignore_cache: ignore_cache, wait: false, file: self.file, url: self.url, type: PrayerCategoryData.self, queries: queries )
        DispatchQueue.main.async { self.res = data }
    }
    
    // Reset to Progress View
    func SetLoading ( ) {
        res = .loading ( [ : ] )
    }
}
