//
//  DateFormatter.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 14/01/2024.
//

import Foundation

func FormatDate ( date: DateFormatter.Style, time: DateFormatter.Style ) -> DateFormatter {
    let formatter = DateFormatter ( )
    formatter.locale = Locale ( identifier: "en_GB" )
    formatter.dateStyle = date
    formatter.timeStyle = time
    return formatter
}

func CurrentWeekday ( ) -> String {
    let today = Calendar.current.component ( .weekday, from: .now )
    return Calendar.current.weekdaySymbols [ today - 1 ]
}

func CurrentMonth ( ) -> String {
    let today = Calendar.current.dateComponents ( [ .month ], from: .now )
    return Calendar.current.shortMonthSymbols [ today.month! - 1 ]
}

func CurrentDay ( add: Int = 0 ) -> Int {
    var dateComponent = DateComponents()
    dateComponent.day = add
    let today = Calendar.current.date ( byAdding: dateComponent, to: .now )
    return Calendar.current.component ( .day, from: today! )
}

func CurrentYear ( ) -> Int {
    return Calendar.current.component ( .year, from: .now )
}
