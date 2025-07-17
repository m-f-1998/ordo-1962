//
//  Ordo.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 15/12/2023.
//

import Foundation
import SwiftData
import OrderedCollections

@Model final class VotiveData: Decodable, @unchecked Sendable {
    var id: String {
        UUID ( ).uuidString
    }
    var title: String
    var masses: Array<Masses>?
    var days: Array<DayGroup>?
    
    required init ( from decoder: Decoder ) throws {
        let values = try decoder.container ( keyedBy: CodingKeys.self )
        self.title = try values.decode ( String.self, forKey: .title )
        if let directMasses = try? values.decode([Masses].self, forKey: .masses) {
            self.masses = directMasses
        }
        else if let dayGroups = try? values.decode([DayGroup].self, forKey: .masses) {
            self.days = dayGroups
        }
        else {
            throw DecodingError.dataCorruptedError(forKey: .masses, in: values, debugDescription: "Unable to decode 'masses' as [Masses] or [DayGroup]")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case title, masses
    }
}

struct DayGroup: Codable, Hashable, Identifiable {
    var id: String = UUID().uuidString // stored once when instance is created

    let day: String
    let votives: [Masses]
    
    init ( day: String = "", votives: Array<Masses> = [] ) {
        self.day = day
        self.votives = votives
    }
    
    enum CodingKeys: String, CodingKey {
        case day, votives
    }
}

struct Masses: Codable, Hashable, Identifiable {
    var id: String = UUID().uuidString // stored once when instance is created
    let rank: Int
    let title: String
    let colors: String
    let propers: Array<Propers>
    
    init ( rank: Int = 1, title: String = "", colors: String = "", propers: Array<Propers> = [] ) {
        self.rank = rank
        self.title = title
        self.colors = colors
        self.propers = propers
    }
    
    enum CodingKeys: String, CodingKey {
        case rank, title, colors, propers
    }
}

struct Propers: Codable, Hashable, Identifiable {
    var id: String = UUID().uuidString // stored once when instance is created
    let title: String
    let english: String
    let latin: String
    
    init ( title: String = "", english: String = "", latin: String = "" ) {
        self.title = title
        self.english = english
        self.latin = latin
    }
    
    enum CodingKeys: String, CodingKey {
        case title, english, latin
    }
}
