//
//  ContentView.swift
//  ordo-1962-watch
//
//  Created by Matthew Frankland on 11/06/2023.
//

import SwiftUI

struct Ordo: View {
    let ordo: [ CelebrationData ]

    var body: some View {
        List ( self.ordo, id: \.self ) { feast in
            VStack ( alignment: .leading, spacing: 3 ) {
                Text ( feast.date ).bold ( )
                ForEach ( feast.celebrations, id: \.id ) { celebration in
                    Text ( celebration.title )
                    Text ( "Class \(celebration.rank)" )
                        .italic ( )
                        .font ( .system ( size: 14 ) )
                }
            }.padding ( )
        }.safeAreaInset ( edge: .bottom ) {
            EmptyView ( ).frame ( height: 8 )
        }
    }
}

struct ErrorView: View {
    let error: String
    let api: API

    var body: some View {
        VStack ( alignment: .center ) {
            Text ( error ).multilineTextAlignment ( .center ).padding ( )
            Button ( action: {
                Task {
                    await self.api.GetData ( )
                }
            } ) {
                Label ( "Try Again", systemImage: "arrow.clockwise" )
            }
        }
    }
}

struct ContentView: View {
    @ObservedObject var api: API = API ( )

    var body: some View {
        VStack {
            switch api.res {
            case .success ( let res ):
                Ordo ( ordo: res )
            case .failure ( let desc ):
                ErrorView ( error: desc, api: api )
            case .loading:
                ProgressView ( )
            case .none:
                ErrorView ( error: "An Unknown Error Occured", api: api )
            }
        }
        .padding ( )
        .task {
            if case .success ( _ ) = self.api.res {
                print ( "Ordo Already At Status Successful" )
            } else {
                await self.api.GetData ( )
            }
        }
    }
}
