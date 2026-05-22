//
//  Error.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 19/04/2023.
//

import SwiftUI

struct ErrorView: View {
    let description: String

    var body: some View {
        NavigationStack {
            ZStack {
                PlaceholderList ( )
                VStack ( spacing: 10 ) {
                    Text ( description )
                }
                    .padding ( )
                    .tint ( .white )
                    .foregroundStyle ( .white )
                    .background ( .black )
                    .clipShape ( RoundedRectangle ( cornerRadius: 10 ) )
            }
        }
    }

}
