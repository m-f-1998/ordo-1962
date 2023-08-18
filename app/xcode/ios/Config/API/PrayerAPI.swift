//
//  PrayersAPI.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 02/07/2023.
//

import Foundation

class PrayerAPI: ObservableObject {
    private let file: String = "prayer.data", url = "prayers.php"
    @Published private ( set ) var res: ResultAPI <PrayerLanguageData>!
    private var api: API = API ( )
    
    init ( ) {
        self.res = self.GetCache ( )
    }

    // Update The Status Of The View Containing Prayers
    func Update ( use_cache: Bool = true ) async {
        if use_cache {
            if case .success ( _ ) = self.res {
                print ( "Prayer Data Already At Status Successful" )
                return
            }
        }

        let data =  await self.api.GetAPI ( use_cache: false, file: self.file, url: self.url, type: PrayerLanguageData.self, queries: [ ] )
        DispatchQueue.main.async {
            self.res = data
        }
    }
    
    // Get Cache Data, Ignore Internet
    func GetCache ( ) -> ResultAPI <PrayerLanguageData> {
        do {
            return .success ( try self.api.GetCache ( file: self.file, type: PrayerLanguageData.self ) )
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
    
    // Get Is Loading ?
    func GetLoading ( ) -> Bool {
        if case .loading = self.res {
            return true
        }
        return false
    }
    
    // Reload on Error
    func ErrorRetry ( ) {
        DispatchQueue.main.async {
            Task {
                self.SetLoading ( )
                try await Task.sleep ( nanoseconds: UInt64 ( 2 * Double ( NSEC_PER_SEC ) ) )
                await self.Update ( )
            }
        }
    }
}
