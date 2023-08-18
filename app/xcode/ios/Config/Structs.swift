//
//  Structs.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import Foundation

// MARK: Propers

typealias PropersData = [ String: [ FeastPropers ] ]
struct FeastPropers: Codable, Hashable, Identifiable {
    let id: String
    let date: String
    let introit: PropersLanguage?
    let collect: PropersLanguage?
    let epistle: PropersLanguage?
    let gradual: PropersLanguage?
    let gospel: PropersLanguage?
    let offertory: PropersLanguage?
    let secret: PropersLanguage?
    let preface: PropersLanguage?
    let communion: PropersLanguage?
    let postcommunion: PropersLanguage?
    
    var dictionary: [ String: PropersLanguage? ] {
        return [
            "introit": introit,
            "collect": collect,
            "epistle": epistle,
            "gradual": gradual,
            "gospel": gospel,
            "offertory": offertory,
            "secret": secret,
            "preface": preface,
            "communion": communion,
            "postcommunion": postcommunion
        ]
    }
}
struct PropersLanguage: Codable, Hashable {
    let english: String
    let latin: String
}

// MARK: Prayers

typealias PrayerLanguageData = [ String : PrayerCategoryData ]
typealias PrayerCategoryData = [ String : PrayerData ]
typealias PrayerData = [ String : String ]

// MARK: Liturgical Ordo

typealias OrdoData = [ String: [ CelebrationData ] ]
struct CelebrationData: Codable, Hashable, Identifiable {
    let id: String
    let date: String
    let celebrations: [ FeastData ]
    let season: SeasonData?
}
struct SeasonData: Codable, Hashable {
    let title: String
    let colors: String
}
struct FeastData: Codable, Hashable, Identifiable {
    let id: String
    let title: String
    let rank: Int
    let colors: String
    let options: String?
    let commemorations: [ FeastData ]?
}
