//
//  Error.swift
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
            Text ( self.description )
                .multilineTextAlignment ( .center )
                .padding ( )
            Button ( action: {
                Task {
                    self.ordo.SetLoading ( )
                    try await Task.sleep ( nanoseconds: UInt64 ( 2 * Double ( NSEC_PER_SEC ) ) )
                    await self.ordo.Update ( )
                }
            } ) {
                Label ( "Try Again", systemImage: "arrow.clockwise" )
            }
        }
    }
}
