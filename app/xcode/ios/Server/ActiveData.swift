//
//  Data.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 13/12/2023.
//

import SwiftUI

class ActiveData: ObservableObject {
    @Published private(set) var loading: Bool = true
    @Published private(set) var downloading: Bool = false
    @Published private(set) var error: Bool = false
    @Published private(set) var percentage = 0

    public private(set) var last_err = ""
    public private(set) var ordo: [ OrdoYear ] = []
    public private(set) var prayers: PrayerLanguageData? = nil

    func SetSuccess ( ordo: [ OrdoYear ], prayers: PrayerLanguageData? ) {
        DispatchQueue.main.async {
            self.ordo = ordo
            self.prayers = prayers
            self.SetStatus ( )
        }
    }
    
    func SetDownload ( download: Int ) {
        self.percentage = download
    }
    
    func SetError ( error: String ) {
        self.last_err = error
        self.SetStatus ( error: true )
    }
    
    func SetStatus ( error: Bool = false, downloading: Bool = false, loading: Bool = false ) {
        self.error = error
        self.downloading = downloading
        self.loading = loading
    }

    func GetIDToday ( ) -> String {
        if self.ordo.count > 0 {
            return self.ordo [ 0 ].getDay ( month: CurrentMonth ( ), day: CurrentDay ( ) ).date.combined
        }
        return ""
    }
    
    func GetYear ( year: Int = CurrentYear ( ) ) -> OrdoYear? {
        let index = year - CurrentYear ( )
        if index < self.ordo.count {
            return self.ordo [ index ]
        }
        return nil
    }
    
    func GetFilteredOrdo ( search: String = "", year: Int = CurrentYear ( ) ) -> [ [ OrdoDay ] ] {
        if let year = self.GetYear ( year: year ) {
            return year.ordo.map {
                return self.Filter ( search: search, data: $0 )
            }.filter {
                return !$0.isEmpty
            }
        }
        return [ ]
    }

    private func Filter ( search: String = "", data: [ OrdoDay ] ) -> [ OrdoDay ] {
        return data.filter {
            if $0.season.title.localizedCaseInsensitiveContains ( search ) {
                return true
            }
            for celebration in $0.celebrations {
                if celebration.title.localizedCaseInsensitiveContains ( search ) {
                    return true
                }
                
                if celebration.commemorations.contains ( where: { $0.title.localizedCaseInsensitiveContains ( search ) } ) {
                    return true
                }
            }
            return false
        }
    }
}
