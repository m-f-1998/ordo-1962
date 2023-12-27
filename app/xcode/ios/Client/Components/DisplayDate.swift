//
//  DateView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI

struct Day: View {
    let day, date, month: String
    var today: Bool = false

    init ( day: String, date: String, month: String, dateObj: Date = .distantPast ) {
        self.day = day
        self.date = date
        self.month = month
        self.today = Calendar.current.isDateInToday ( dateObj )
    }

    var body: some View {
        LazyVStack {
            Text ( self.day )
            Text ( self.date )
                .font ( .system ( size: 24 ) )
                .bold ( )
            Text ( self.month )
        }
            .frame ( maxWidth: 60, maxHeight: .infinity )
            .font ( .system ( size: 14 ) )
            .multilineTextAlignment ( .center )
            .background ( self.today ? LinearGradient ( colors: [ .red, .orange ] ) : LinearGradient ( ) )
            .clipShape ( RoundedRectangle ( cornerRadius: 8 ) )
    }
}
