//
//  Ordo.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 15/12/2023.
//

import Foundation
import SwiftData

@Model class OrdoYear: Decodable, Hashable, Identifiable {
    let id: String = UUID ( ).uuidString
    public private(set) var ordo: [ [ OrdoDay ] ]
    public private(set) var year: Int
    public private(set) var date: Date = Date()

    init ( ordo: Array<Array<OrdoDay>>, year: Int ) {
        self.ordo = ordo
        self.year = year
    }
    
    required init ( from decoder: Decoder ) throws {
        let values = try decoder.container ( keyedBy: CodingKeys.self )
        self.year = try values.decode ( Int.self, forKey: .Year )
        self.ordo = try values.decode ( Array<Array<OrdoDay>>.self, forKey: .Ordo )
    }
    
    private enum CodingKeys: String, CodingKey {
        case Ordo, Year
    }
    
    static func == ( lhs: OrdoYear, rhs: OrdoYear ) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash ( into hasher: inout Hasher ) {
        return hasher.combine ( id )
    }

    func getMonth ( month: String ) -> [ OrdoDay ] {
        return self.ordo [ Calendar.current.shortMonthSymbols.firstIndex ( of: month )! ]
    }

    func getDay ( month: String, day: Int ) -> OrdoDay {
        let res = self.getMonth ( month: month )
        if day <= res.count {
            return res [ day - 1 ]
        }
        return OrdoDay ( )
    }
}

struct OrdoDay: Codable, Hashable, Identifiable {
    let id: String = UUID ( ).uuidString
    let date: String
    let month: String
    let celebrations: [ CelebrationData ]
    let season: SeasonData

    init ( date: String = FormatDate ( ).string ( from: .now ), celebrations: [ CelebrationData ] = [ CelebrationData ( ) ], season: SeasonData = SeasonData ( title: "", colors: "" ), month: String = CurrentMonth ( ) ) {
        self.date = date
        self.celebrations = celebrations
        self.season = season
        self.month = month
    }

    enum CodingKeys: String, CodingKey {
        case date, celebrations, season, month
    }

    static func == (lhs: OrdoDay, rhs: OrdoDay) -> Bool {
        lhs.id == rhs.id
    }

    public func hash ( into hasher: inout Hasher ) {
        return hasher.combine ( id )
    }
}

struct CelebrationData: Codable, Hashable, Identifiable {
    let id: String = UUID ( ).uuidString
    let rank: Int
    let title: String
    let colors: String
    let options: String
    let propers: [ PropersData ]
    let commemorations: [ CommemorationData ]

    init ( rank: Int = 1, title: String = String ( repeating: "*", count: 10 ), colors: String = String ( repeating: "*", count: 10 ), options: String = String ( repeating: "*", count: 10 ), propers: [ PropersData ] = [ ], commemorations: [ CommemorationData ] = [ ] ) {
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
    
    static func == ( lhs: CelebrationData, rhs: CelebrationData ) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash ( into hasher: inout Hasher ) {
        return hasher.combine(id)
    }
    
    private func FormatProperString ( proper: PropersData, lang: String, first: Bool = false ) -> String {
        var res = first ? "" : "\n\n"
        res += "**\( String ( describing: proper.GetTitle ( )! ) )**\n"
        res += proper.GetPrayer ( lang: lang )
        return res
    }
    
    public func GetPropers ( lang: String ) -> String {
        var res = ""
        propers.forEach { proper in
            res += FormatProperString ( proper: proper, lang: lang, first: res == "" )
            if let index = [ "Collect", "Secret", "Postcommunion" ].firstIndex ( where: { $0 == proper.GetTitle ( )! } ) {
                commemorations.forEach { commem in
                    if commem.propers.count > 0 {
                        res += FormatProperString ( proper: commem.propers [ index ], lang: lang )
                    }
                }
            }
        }
        return res
    }
}

struct CommemorationData: Codable, Hashable, Identifiable {
    let id: String = UUID ( ).uuidString
    let title: String
    let rank: Int
    let colors: String
    let propers: [ PropersData ]

    enum CodingKeys: String, CodingKey {
        case title, rank, colors, propers
    }
    
    static func == ( lhs: CommemorationData, rhs: CommemorationData ) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}
