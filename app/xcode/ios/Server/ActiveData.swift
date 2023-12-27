//
//  Data.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 13/12/2023.
//

import SwiftUI

class Data: ObservableObject {

    private var data: OrdoYear? = nil
    @State private var loading: Bool = true
    @State private var downloading: Bool = false

    // MARK: Setters
    func SetLoading ( ) {
        self.downloading = false
        self.loading = true
    }
    
    func SetDownloading ( ) {
        self.downloading = true
        self.loading = false
    }
    
    func SetSuccess ( ) {
        self.downloading = false
        self.loading = false
    }
    
    func SetData ( data: OrdoYear ) {
        self.data = data
    }
    
    // MARK: Getters
    func GetDownloading ( ) -> Bool {
        return self.downloading
    }
    
    func GetLoading ( ) -> Bool {
        return self.loading
    }
    
    func GetData ( ) -> OrdoYear? {
        return self.data
    }
    
    // Get ID Of Today's Feast
    func GetIDToday ( ) -> String? {
        if let ordo = data {
            return ordo.getDay ( month: CurrentMonth ( ), day: CurrentDay ( ) - 1 ).id
        }
        return ""
    }

    // Get Data, Filtered If Search
    func GetFilteredOrdo ( search: String = "" ) -> OrdoYear {
        if let ordo = data {
            if search != "" {
                return OrdoYear ( dictionary: ordo.allMonths ( ).mapValues { value in
                    return self.Filter ( data: value )
                } )
            }
            return ordo
        }
        return OrdoYear ( )
    }

    // Filter Celebration Data If Search Contained In Title(s)
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
