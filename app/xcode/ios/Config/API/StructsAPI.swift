//
//  Structs.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 02/07/2023.
//

import Foundation

enum ResultAPI <T:Equatable>: Equatable {
    case loading ( T ), success ( T ), failure ( String )
}

enum ErrorAPI: Error {
    case fetching ( String ), saving
}
