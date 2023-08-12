//
//  PrayersAPI.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 02/07/2023.
//

import Foundation

class PrayerAPI: ObservableObject {
    private let file: String = "prayer.data", url = "prayers.php"
    @Published private ( set ) var res: ResultAPI <PrayerCategoryData>!
    private var api: API = API ( )
    
    init ( ) {
        self.res = self.GetCache ( )
    }

    // Update The Status Of The View Containing Prayers
    func Update ( lang: String ) async {
        switch self.res {
        case .success ( _ ):
            print ( "Prayer Data Already At Status Successful" )
        default:
            // MARK: Return Languages Together
            let queries = [
                URLQueryItem ( name: "lang", value: lang )
            ]
            
            let data =  await self.api.GetAPI ( cache: false, file: self.file, url: self.url, type: PrayerCategoryData.self, queries: queries )
            DispatchQueue.main.async {
                self.res = data
            }
        }
    }
    
    // Get Cache Data, Ignore Internet
    func GetCache ( ) -> ResultAPI <PrayerCategoryData> {
        do {
            return .success ( try self.api.GetCache ( file: self.file, type: PrayerCategoryData.self ) )
        } catch ErrorAPI.fetching {
            return .loading ( [ : ] )
        } catch {
            return .failure ( error.localizedDescription )
        }
    }
    
    // Reset to Progress View
    func SetLoading ( ) {
        res = .loading ( [ : ] )
    }
}
