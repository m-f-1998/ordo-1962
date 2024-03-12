//
//  LocalFeast.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 28/01/2024.
//

import SwiftUI

struct LocalFeast: View {
    var data: LocaleData
    @Environment ( \.colorScheme ) var colorScheme

    var body: some View {
        VStack {
            HStack ( spacing: 10 ) {
                VStack {
                    Text ( data.date )
                        .bold ( )
                        .padding ( )
                        .multilineTextAlignment ( .center )
                        .lineLimit ( nil )
                }
                .frame ( maxWidth: 120, maxHeight: .infinity )
                .background ( LinearGradient ( ) )
                .clipShape ( RoundedRectangle ( cornerRadius: 8 ) )
                VStack ( alignment: .leading ) {
                    HStack {
                        Text ( data.title )
                            .frame ( alignment: .leading )
                            .font ( .system ( size: 14.0 ) )
                            .bold ( )
                        ForEach ( data.colors.components ( separatedBy: "," ), id: \.self ) {
                            Circle ( )
                                .strokeBorder ( colorScheme == .dark ? .white : .black, lineWidth: 1 )
                                .background (
                                    Circle ( )
                                        .foregroundColor ( Color ( word: $0 ) )
                                )
                                .frame ( width: 15, height: 15 )
                        }
                    }
                }
            }
        }
        .padding ( [ .vertical ], 8 )
    }
}

