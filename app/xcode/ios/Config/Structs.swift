//
//  Structs.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import Foundation

// MARK: Config
struct AppSettings: Codable, Hashable {
    let latest_version: Double
    let api_updated: Int
}

struct PropersLanguage: Codable, Hashable {
    let title: String?
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

// MARK: Ordo

typealias OrdoMonth = [ String: [ OrdoDay ] ]
struct OrdoDay: Codable, Hashable, Identifiable {
    var id: String {
        return UUID ( ).uuidString
    }
    let date: String
    let celebrations: [ OrdoCelebration ]
    let season: SeasonData
    
    enum CodingKeys: String, CodingKey {
        case date, celebrations, season
    }
}

struct SeasonData: Codable, Hashable {
    let title: String
    let colors: String
}

struct OrdoCelebration: Codable, Hashable, Identifiable {
    let id: String = UUID ( ).uuidString
    let rank: Int
    let title: String
    let colors: String
    let options: String
    let propers: [ PropersLanguage ]
    let commemorations: [ OrdoCommemorations ]
    
    enum CodingKeys: String, CodingKey {
        case title, rank, colors, options, propers, commemorations
    }
}

struct OrdoCommemorations: Codable, Hashable, Identifiable {
    let id: String = UUID ( ).uuidString
    let title: String
    let rank: Int
    let colors: String
    let propers: [ PropersLanguage ]
    
    enum CodingKeys: String, CodingKey {
        case title, rank, colors, propers
    }
}
