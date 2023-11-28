//
//  DateView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI

struct Day: View {
    let day, date, month: String
    private var today: Bool = false

    init ( feast_date: String, month: String ) {
        let date_split = feast_date.components ( separatedBy: " " )
        
        self.date = date_split [ 1 ]
        self.month = String ( month.prefix ( 3 ) )
        self.day = date_split [ 0 ]
        
        self.today = FormatDate ( short: true ).string ( from: .now ).contains ( "\(self.day) \(self.date) \(self.month)" )
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
            .multilineTextAlignment( .center )
            .background ( self.today ? LinearGradient ( colors: [ .red, .orange ] ) : LinearGradient ( ) )
            .clipShape ( RoundedRectangle ( cornerRadius: 8 ) )
    }
}
