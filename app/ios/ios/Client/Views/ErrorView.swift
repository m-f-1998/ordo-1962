//
//  Error.swift
//  ordo-1962
//

import SwiftUI

struct ErrorView: View {
    let description: String
    var retryAction: ( ( ) -> Void )? = nil

    var body: some View {
        NavigationStack {
            VStack ( spacing: 20 ) {
                Image ( systemName: "exclamationmark.triangle.fill" )
                    .font ( .system ( size: 50 ) )
                    .foregroundStyle ( .red )
                
                Text ( "An Error Occurred" )
                    .font ( .title2 )
                    .fontWeight ( .bold )
                    .foregroundStyle ( .primary )
                
                Text ( description )
                    .font ( .body )
                    .foregroundStyle ( .secondary )
                    .multilineTextAlignment ( .center )
                    .padding ( .horizontal, 30 )
                
                if let retry = retryAction {
                    Button {
                        retry ( )
                    } label: {
                        Label ( "Retry Connection", systemImage: "arrow.clockwise" )
                            .fontWeight ( .semibold )
                            .padding ( .horizontal, 24 )
                            .padding ( .vertical, 12 )
                            .background ( Color.red )
                            .foregroundStyle ( .white )
                            .clipShape ( RoundedRectangle ( cornerRadius: 10 ) )
                    }
                    .padding ( .top, 10 )
                }
            }
            .padding ( )
            .frame ( maxWidth: .infinity, maxHeight: .infinity )
            .background ( Color ( .systemBackground ) )
        }
    }
}
