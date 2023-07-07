//
//  Structs.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 23/03/2023.
//

import SwiftUI

// MARK: Prayers

typealias PrayerCategoryData = [ String : PrayerData ]
typealias PrayerData = [ String : String ]

// MARK: Liturgical Ordo

typealias OrdoData = [ String: [ CelebrationData ] ]

struct CelebrationData: Codable, Hashable, Identifiable {
    let id: String
    let date: String
    let celebration: [ FeastData ]
    let commemoration: [ FeastData ]
    let season: SeasonData
    let options: String
}

struct SeasonData: Codable, Hashable {
    let title: String
    let colors: [ String ]
}

struct FeastData: Codable, Hashable, Identifiable {
    let id: String = UUID ( ).uuidString
    let title: String
    let rank: Int
    let colors: [ String ]
    
    private enum CodingKeys: String, CodingKey { case title, rank, colors }
}
