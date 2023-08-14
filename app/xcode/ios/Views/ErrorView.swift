//
//  Error.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 19/04/2023.
//

import SwiftUI

struct ErrorView: View {
    let description: String
    
    var Callback: () -> ()

    var body: some View {
        VStack ( alignment: .center ) {
            Text ( "Something Went Wrong" )
                .multilineTextAlignment ( .center )
                .font ( .largeTitle )
                .bold ( )
            Text ( self.description )
                .multilineTextAlignment ( .center )
                .padding ( )
            Button ( action: self.Callback ) {
                Label ( "Try Again", systemImage: "arrow.clockwise" )
            }
        }
            .padding ( [ .leading, .trailing ], 8 )
    }
}
