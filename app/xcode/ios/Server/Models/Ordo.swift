//
//  Ordo.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 15/12/2023.
//

import Foundation
import SwiftData

@Model class OrdoYear: Decodable {
    private var res: [ String : [ OrdoDay ] ] = [ : ]
    public private(set) var year: Int
    public private(set) var date: Date = Date()

    init ( dictionary: [ String : [ OrdoDay ] ] = Calendar.current.shortMonthSymbols.reduce ( into: [ : ] ) {
        $0 [ $1 ] = [ OrdoDay ( ) ]
    }, year: Int = CurrentYear ( ) ) {
        self.res = dictionary
        self.year = year
    }
    
    required init ( from decoder: Decoder ) throws {
        let values = try decoder.container ( keyedBy: CodingKeys.self )
        self.year = try values.decode ( Int.self, forKey: .year )
        self.res = [
            "Jan": try values.decode ( [ OrdoDay ].self, forKey: .Jan ),
            "Feb": try values.decode ( [ OrdoDay ].self, forKey: .Feb ),
            "Mar": try values.decode ( [ OrdoDay ].self, forKey: .Mar ),
            "Apr": try values.decode ( [ OrdoDay ].self, forKey: .Apr ),
            "May": try values.decode ( [ OrdoDay ].self, forKey: .May ),
            "Jun": try values.decode ( [ OrdoDay ].self, forKey: .Jun ),
            "Jul": try values.decode ( [ OrdoDay ].self, forKey: .Jul ),
            "Aug": try values.decode ( [ OrdoDay ].self, forKey: .Aug ),
            "Sep": try values.decode ( [ OrdoDay ].self, forKey: .Sep ),
            "Oct": try values.decode ( [ OrdoDay ].self, forKey: .Oct ),
            "Nov": try values.decode ( [ OrdoDay ].self, forKey: .Nov ),
            "Dec": try values.decode ( [ OrdoDay ].self, forKey: .Dec )
        ]
    }
    
    private enum CodingKeys: String, CodingKey {
        case Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec, year
    }
    
    func allMonths ( ) -> [ String : [ OrdoDay ] ] {
        return res
    }
    
    func getMonth ( month: String ) -> [ OrdoDay ]? {
        return res [ month ]
    }

    func getDay ( month: String, day: Int ) -> OrdoDay {
        if let month = self.res [ month ] {
            return month [ day ]
        }
        return OrdoDay ( )
    }
}

struct OrdoDay: Codable, Hashable, Identifiable {
    static func == (lhs: OrdoDay, rhs: OrdoDay) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String {
        return UUID ( ).uuidString
    }
    let date: String
    let celebrations: [ OrdoCelebration ]
    let season: SeasonData
    
    init ( date: String = FormatDate ( ).string ( from: .now ), celebrations: [ OrdoCelebration ] = [
        OrdoCelebration ( )
    ], season: SeasonData = SeasonData ( title: "Test Season", colors: "g" ) ) {
        self.date = date
        self.celebrations = celebrations
        self.season = season
    }
    
    public func hash ( into hasher: inout Hasher ) {
        return hasher.combine ( id )
    }
    
    enum CodingKeys: String, CodingKey {
        case date, celebrations, season
    }
}

struct OrdoCelebration: Codable, Hashable, Identifiable {
    static func == (lhs: OrdoCelebration, rhs: OrdoCelebration) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    let id: String = UUID ( ).uuidString
    let rank: Int
    let title: String
    let colors: String
    let options: String
    let propers: [ PropersData ]
    let commemorations: [ OrdoCommemorations ]
    
    init ( rank: Int = 1, title: String = "Dummy Title", colors: String = "w", options: String = "Dummy Options", propers: [ PropersData ] = [ ], commemorations: [ OrdoCommemorations ] = [] ) {
        self.rank = rank
        self.title = title
        self.colors = colors
        self.options = options
        self.propers = propers
        self.commemorations = commemorations
    }
    
    enum CodingKeys: String, CodingKey {
        case title, rank, colors, options, propers, commemorations
    }
}

struct OrdoCommemorations: Codable, Hashable, Identifiable {
    static func == (lhs: OrdoCommemorations, rhs: OrdoCommemorations) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    let id: String = UUID ( ).uuidString
    let title: String
    let rank: Int
    let colors: String
    let propers: [ PropersData ]
    
    enum CodingKeys: String, CodingKey {
        case title, rank, colors, propers
    }
}
