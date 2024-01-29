// //
// //  Prayers.swift
// //  ordo-1962
// //
// //  Created by Matthew Frankland on 15/12/2023.
// //

// import Foundation
// import SwiftData

// @Model class PrayerLanguageData: Decodable {
//     private var res: [ String : PrayerCategoryData ] = [ : ]
    
//     required init ( from decoder: Decoder ) throws {
//         let values = try decoder.container ( keyedBy: CodingKeys.self )
//         self.res = [
//             "English": try values.decode ( PrayerCategoryData.self, forKey: .English ),
//             "Latin": try values.decode ( PrayerCategoryData.self, forKey: .Latin )
//         ]
//     }
    
//     private enum CodingKeys: String, CodingKey {
//         case English, Latin
//     }
    
//     func GetPrayer ( lang: String, category: String, name: String ) -> String {
//         if let language = res [ lang ] {
//             if let cat = language [ category ] {
//                 if let prayer = cat [ name ] {
//                     return prayer
//                 }
//             }
//         }
//         return ""
//     }
    
//     func GetPrayerNames ( lang: String, cat: String ) -> [ String ] {
//         if let lang = self.res [ lang ] {
//             if let prayer = lang [ cat ] {
//                 return prayer.keys.sorted ( by: < )
//             }
//         }
//         return [ ]
//     }
    
//     func GetCategories ( lang: String ) -> [ String ] {
//         if let lang = self.res [ lang ] {
//             return lang.keys.sorted ( by: < )
//         }
//         return [ ]
//     }
    
//     func GetLanguageDetails ( ) -> [ String ] {
//         return [ "English", "Latin" ].sorted ( by: < )
//     }
// }

// typealias PrayerCategoryData = [ String : PrayerData ]
// typealias PrayerData = [ String : String ]
