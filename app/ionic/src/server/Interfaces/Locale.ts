// //
// //  Locale.swift
// //  ordo-1962
// //
// //  Created by Matthew Frankland on 27/01/2024.
// //

// import SwiftData
// import Foundation
// import OrderedCollections

// struct LocaleData: Codable, Hashable {
//     var date: String
//     var title: String
//     var colors: String
// }

// struct LocaleCountries: Codable, Hashable {
//     var countries: [ String ]
//     var locale: [ String: LocaleDioceses ]
// }

// struct LocaleDioceses: Codable, Hashable {
//     var dioceses: [ String ]
//     var locale: [ String: [ LocaleData ] ]
// }

// @Model class LocaleOrdo: Decodable, Hashable, Identifiable {
//     let id: String = UUID ( ).uuidString
//     public private(set) var certain_locations: [ LocaleData ]
//     public private(set) var feasts: LocaleCountries

//     required init ( from decoder: Decoder ) throws {
//         let values = try decoder.container ( keyedBy: CodingKeys.self )
//         self.certain_locations = try values.decode ( [ LocaleData ].self, forKey: .in_certain_locations )
//         self.feasts = try values.decode ( LocaleCountries.self, forKey: .feasts )
//     }

//     private enum CodingKeys: String, CodingKey {
//         case in_certain_locations, feasts
//     }
    
//     static func == ( lhs: LocaleOrdo, rhs: LocaleOrdo ) -> Bool {
//         lhs.id == rhs.id
//     }
    
//     public func hash ( into hasher: inout Hasher ) {
//         return hasher.combine ( id )
//     }
// }
