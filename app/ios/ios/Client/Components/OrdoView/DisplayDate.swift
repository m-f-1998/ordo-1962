//
//  DateView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI

struct DisplayDate: View {
    @Environment(ActiveData.self) var activeData

    let day, date, month: String
    var today: Bool = false

    init ( date: DateInfo ) {
        self.day = date.weekday
        self.date = date.day
        self.month = date.month

        let formatter = FormatDate ( date: .medium, time: .none )
        self.today = formatter.date ( from: date.combined ).map { Calendar.current.isDateInToday ( $0 ) } ?? false
    }

    private var theme: LiturgicalTheme {
        if today, let day = activeData.GetYear ( )?.getDay ( month: CurrentMonth ( ), day: CurrentDay ( ) ) {
            return LiturgicalTheme ( day: day )
        }
        return LiturgicalTheme ( colors: "g" )
    }

    var body: some View {
        VStack ( spacing: 2 ) {
            Text ( self.day )
                .font ( .system ( size: 11 ) )
            Text ( self.date )
                .font ( .system ( size: 22, weight: .bold ) )
            Text ( self.month )
                .font ( .system ( size: 11 ) )
        }
            .frame ( maxWidth: 52, maxHeight: .infinity )
            .multilineTextAlignment ( .center )
            .foregroundStyle ( .primary )
            .background ( Color.clear )
            .clipShape ( RoundedRectangle ( cornerRadius: 8 ) )
    }
}
