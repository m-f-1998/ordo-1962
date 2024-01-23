//
//  TabbedItems.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 21/01/2024.
//

import Foundation

enum TabItems: Int, CaseIterable {
    case ordo = 0
    case prayer
    case settings
    
    var systemImage: Bool {
        switch self {
            case .prayer:
                return false
            default:
                return true
        }
    }
    
    var title: String {
        switch self {
            case .ordo:
                return "Ordo"
            case .prayer:
                return "Prayer"
            case .settings:
                return "Settings"
        }
    }
    
    var icon: String{
        switch self {
            case .ordo:
                return "calendar"
            case .prayer:
                return "pray"
            case .settings:
                return "gear"
        }
    }
}
