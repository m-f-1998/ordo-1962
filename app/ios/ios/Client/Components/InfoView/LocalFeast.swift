//
//  LocalFeast.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 28/01/2024.
//

import SwiftUI

struct LocalFeast: View {
    var data: LocaleData

    var body: some View {
        VStack ( alignment: .leading, spacing: 8 ) {
            // Sleek Header (Date)
            Text ( data.date.uppercased ( ) )
                .font ( .system ( size: 12, weight: .bold, design: .serif ) )
                .foregroundStyle ( Color ( red: 0.65, green: 0.08, blue: 0.08 ) )
                .tracking ( 1.2 )
                .padding ( .top, 14 )
                .padding ( .horizontal, 16 )
            
            Divider ( )
                .background ( Color ( red: 0.65, green: 0.08, blue: 0.08 ).opacity ( 0.15 ) )
                .padding ( .horizontal, 16 )
            
            // Sleek Content (Feast Title)
            Text ( data.title )
                .font ( .system ( size: 14, weight: .semibold, design: .serif ) )
                .foregroundStyle ( .primary )
                .multilineTextAlignment ( .leading )
                .padding ( .horizontal, 16 )
                .padding ( .bottom, 14 )
        }
        .frame ( maxWidth: .infinity, alignment: .leading )
        .background ( Color ( .secondarySystemBackground ) )
        .clipShape ( RoundedRectangle ( cornerRadius: 16 ) )
        .padding ( .horizontal, 16 )
        .padding ( .vertical, 6 )
    }
}
