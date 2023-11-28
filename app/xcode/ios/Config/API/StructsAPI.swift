//
//  StructsAPI.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 02/07/2023.
//

enum ResultAPI <T:Equatable>: Equatable {
    case loading, success ( T ), failure ( String )
}

enum ErrorAPI: Error {
    case fetching ( String ), saving
}
