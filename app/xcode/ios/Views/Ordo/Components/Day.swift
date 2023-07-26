//
//  DateView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI

struct Day: View {
    let day, date, month: String

    init ( date: String, month: String ) {
        let date_split = date.components ( separatedBy: " " )
        self.date = date_split [ 1 ]
        self.month = String ( month.prefix ( 3 ) )
        self.day = date_split [ 0 ]
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
            .multilineTextAlignment( .center )
            .background ( LinearGradient ( ) )
            .clipShape ( RoundedRectangle ( cornerRadius: 8 ) )
    }
}
