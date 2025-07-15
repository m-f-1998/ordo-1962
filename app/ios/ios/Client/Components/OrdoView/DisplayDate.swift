//
//  DateView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI

struct DisplayDate: View {
    let day, date, month: String
    var today: Bool = false

    init ( date: DateInfo ) {
        self.day = date.weekday
        self.date = date.day
        self.month = date.month
        
        let formatter = FormatDate ( date: .medium, time: .none )
        self.today = Calendar.current.isDateInToday ( formatter.date ( from: date.combined )! )
    }

    var body: some View {
        VStack {
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
