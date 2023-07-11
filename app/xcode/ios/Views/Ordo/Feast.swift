//
//  FeastView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI

struct Feast: View { // Information row on the feast of the day
    var data: [ FeastData ]
    var font: CGFloat
    var comm: Bool = false

    var body: some View {
        ForEach ( self.data, id: \.self ) { feast in
            HStack {
                Text ( feast.title + ( self.comm ? " (Commem)" : "" ) )
                    .frame ( alignment: .leading )
                    .scaledFont ( size: self.font )
                    .bold ( )
                Circle ( )
                    .strokeBorder ( .black, lineWidth: 1 )
                    .background (
                        Circle ( )
                            .foregroundColor ( Color ( word: feast.colors [ 0 ] ) )
                    )
                    .frame ( width: 15, height: 15 )
            }
        }
    }
}
