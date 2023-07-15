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
}
struct PropersLanguage: Codable, Hashable {
    let english: String
    let latin: String
}


// MARK: Prayers

typealias PrayerCategoryData = [ String : PrayerData ]
typealias PrayerData = [ String : String ]

// MARK: Liturgical Ordo

typealias OrdoData = [ String: [ CelebrationData ] ]
typealias ReducedOrdoData = [ String: [ ReducedCelebrationData ] ]

struct CelebrationData: Codable, Hashable, Identifiable {
    let id: String
    let date: String
    let celebration: [ FeastData ]
    let commemoration: [ FeastData ]
    let season: SeasonData
    let options: String
}
struct ReducedCelebrationData: Codable, Hashable, Identifiable {
    let id: String
    let date: String
    let celebration: [ FeastData ]
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
    
    private enum CodingKeys: String, CodingKey { case title, rank, colors }
}
