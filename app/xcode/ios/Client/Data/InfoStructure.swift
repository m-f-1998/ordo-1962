//
//  Info.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 22/01/2024.
//

import OrderedCollections

struct Info: Hashable {
    var header: String
    var footer: String
    var data: OrderedDictionary<String, CelebrationData>
}

var InfoStructure: [ Info ] = [
    Info (
        header: "Votive Masses of Particular Piety",
        footer: "",
        data: votive_piety
    ),
    Info (
        header: "Recommended Votive Masses per Day",
        footer: "Monday",
        data: votive_monday
    ),
    Info (
        header: "",
        footer: "Tuesday",
        data: votive_tuesday
    ),
    Info (
        header: "",
        footer: "Wednesday",
        data: votive_wednesday
    ),
    Info (
        header: "",
        footer: "Thursday",
        data: votive_thursday
    ),
    Info (
        header: "",
        footer: "Friday",
        data: votive_friday
    ),
    Info (
        header: "",
        footer: "Votive Masses of Our Lady",
        data: votive_our_lady
    ),
    Info (
        header: "Other Votive Masses (Not Exhaustive)",
        footer: "",
        data: votive_propers
    )
]
