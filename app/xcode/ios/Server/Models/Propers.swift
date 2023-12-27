//
//  Propers.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 15/12/2023.
//

import Foundation

struct PropersData: Codable {
    private let title: String?
    public let english: String
    public let latin: String
    private var prayers: [ String: String ]
    
    init ( title: String?, english: String, latin: String ) {
        self.title = title
        self.english = english
        self.latin = latin
        self.prayers = [ "English": english, "Latin": latin ]
    }
    
    init ( from decoder: Decoder ) throws {
        let values = try decoder.container ( keyedBy: CodingKeys.self )
        self.title = try values.decode ( String.self, forKey: .title )
        self.english = try values.decode ( String.self, forKey: .english )
        self.latin = try values.decode ( String.self, forKey: .latin )
        self.prayers = [
            "English": try values.decode ( String.self, forKey: .english ),
            "Latin": try values.decode ( String.self, forKey: .latin )
        ]
    }
    
    enum CodingKeys: String, CodingKey {
        case title, english, latin
    }
    
    func GetTitle ( ) -> String? {
        return self.title
    }
    
    func GetPrayer ( lang: String ) -> String {
        if let prayer = self.prayers [ lang ] {
            return prayer
        }
        return ""
    }
}
