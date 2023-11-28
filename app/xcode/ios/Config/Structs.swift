//
//  Structs.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import Foundation

// MARK: Propers

struct FeastPropers: Codable, Hashable {
    let introit: PropersLanguage?
    let collect: PropersLanguage?

    let lectio_l1: PropersLanguage?
    let graduale_l1: PropersLanguage?
    let oratio_l1: PropersLanguage?
    let lectio_l2: PropersLanguage?
    let graduale_l2: PropersLanguage?
    let oratio_l2: PropersLanguage?
    let lectio_l3: PropersLanguage?
    let graduale_l3: PropersLanguage?
    let oratio_l3: PropersLanguage?
    let lectio_l4: PropersLanguage?
    let graduale_l4: PropersLanguage?
    let oratio_l4: PropersLanguage?
    let lectio_l5: PropersLanguage?
    let oratio_l5: PropersLanguage?

    let epistle: PropersLanguage?
    let gradual: PropersLanguage?
    let sequentia: PropersLanguage?
    let gospel: PropersLanguage?
    let offertory: PropersLanguage?
    let secret: PropersLanguage?
    let commemoratio_secreta: PropersLanguage?

    let preface: PropersLanguage?
    let communion: PropersLanguage?
    let postcommunion: PropersLanguage?
    let commemoratio_postcommunio: PropersLanguage?
    let super_populum: PropersLanguage?
    
    var dictionary: [ String: PropersLanguage? ] {
        return [
            "introit": introit,
            "collect": collect,
            "epistle": epistle,
            "gradual": gradual,
            "sequence": sequentia,
            "gospel": gospel,
            "offertory": offertory,
            "secret": secret,
            "preface": preface,
            "communion": communion,
            "postcommunion": postcommunion,
            "first lesson": lectio_l1,
            "first gradual": graduale_l1,
            "first collect": oratio_l1,
            "second lesson": lectio_l2,
            "second gradual": graduale_l2,
            "second collect": oratio_l2,
            "third lesson": lectio_l3,
            "third gradual": graduale_l3,
            "third collect": oratio_l3,
            "fourth lesson": lectio_l4,
            "fourth gradual": graduale_l4,
            "fourth collect": oratio_l4,
            "fifth lesson": lectio_l5,
            "fifth collect": oratio_l5,
            "prayer over the people": super_populum
        ]
    }
}
struct PropersLanguage: Codable, Hashable {
    let english: String
    let latin: String
    
    var dictionary: [ String: String ] {
        return [
            "english": english,
            "latin": latin
        ]
    }
}

// MARK: Prayers

typealias PrayerLanguageData = [ String : PrayerCategoryData ]
typealias PrayerCategoryData = [ String : PrayerData ]
typealias PrayerData = [ String : String ]

// MARK: Liturgical Ordo

typealias OrdoMonth = [ String: [ CelebrationData ] ]
struct CelebrationData: Codable, Hashable, Identifiable {
    let id = UUID ( ).uuidString
    let date: String
    let celebrations: [ FeastData ]
    let season: SeasonData
    
    enum CodingKeys: String, CodingKey {
        case date, celebrations, season
    }
}
struct SeasonData: Codable, Hashable {
    let title: String
    let colors: String
}
struct FeastData: Codable, Hashable, Identifiable {
    let id: String = UUID ( ).uuidString
    let title: String
    let rank: Int
    let colors: String
    let options: String?
    let propers: FeastPropers?
    let commemorations: [ FeastData ]?
    
    enum CodingKeys: String, CodingKey {
        case title, rank, colors, options, propers, commemorations
    }
}
