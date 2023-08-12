//
//  iCalStructs.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/08/2023.
//

import Foundation

enum iCalError: Error {
    case calendar, duplicate
}

struct iCalResult {
    var data: String = ""
    var state: iCalState
}

enum iCalState {
    case success, failure, loading, not_showing
}
