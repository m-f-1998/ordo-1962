//
//  ErrorView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 19/04/2023.
//

import SwiftUI

struct ErrorView: View {
    let description: String
    @EnvironmentObject var ordo: OrdoAPI

    var body: some View {
        VStack ( alignment: .center ) {
            Text ( description )
                .multilineTextAlignment ( .center )
                .padding ( )
            Button ( action: {
                Task {
                    await self.ordo.Update ( )
                }
            } ) {
                Label ( "Try Again", systemImage: "arrow.clockwise" )
            }
        }
    }
}
