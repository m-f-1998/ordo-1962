//
//  PrayersAPI.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 02/07/2023.
//

import Foundation

class PrayerAPI: ObservableObject {
    private let file: String = "prayer.data", url = "prayers.php"
    @Published private ( set ) var res: ResultAPI <PrayerCategoryData> = .loading ( [ : ] as PrayerCategoryData )
    private var api: API = API ( )

    // Update The Status Of The Sheet Containing Prayers
    func Update ( ignore_cache: Bool = false ) async {
        let data =  await api.GetData ( ignore_cache: ignore_cache, wait: false, file: file, url: url, type: PrayerCategoryData.self )
        DispatchQueue.main.async { self.res = data }
    }
}
