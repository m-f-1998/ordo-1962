//
//  ContentView.swift
//  ordo-1962-watch
//
//  Created by Matthew Frankland on 11/06/2023.
//

import SwiftUI

struct Ordo: View {
    let ordo: [ OrdoDay ]

    var body: some View {
        List ( self.ordo, id: \.self ) { feast in
            VStack ( alignment: .leading, spacing: 3 ) {
                Text ( "\(feast.date.combined)" ).bold ( )
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
                    do {
                        try await self.api.UpdateCache ( )
                    } catch {
                        print ( "Can't Update Cache" )
                    }
                }
            } ) {
                Label ( "Try Again", systemImage: "arrow.clockwise" )
            }
        }
    }
}

struct ContentView: View {
    @ObservedObject var activeData: ActiveData
    @State var api: API

    init ( ) {
        let activeData = ActiveData ( )
        self.activeData = activeData
        self.api = API ( activeData: activeData )
    }

    var body: some View {
        VStack {
            if self.activeData.loading {
                ProgressView ( ).onAppear {
                    do {
                        if try self.api.cache.CurrentCacheExists ( ) {
                            self.activeData.SetSuccess ( ordo: try self.api.cache.GetOrdo ( ), prayers: nil )
                        } else {
                            Task {
                                self.activeData.SetSuccess ( ordo: [ try await self.api.GetCurrent ( ) ], prayers: nil )
                            }
                        }
                    } catch {
                        print ( error )
                    }
                }
            } else if self.activeData.error {
                ErrorView ( error: "An Unknown Error Occured", api: api )
            } else {
                if self.activeData.ordo.count > 0 {
                    Ordo ( ordo: self.activeData.ordo[ 0 ].getMonth ( month: CurrentMonth ( ) ) )
                } else {
                    ErrorView ( error: "No Data is Available", api: api )
                }
            }
        }
        .padding ( )
    }
}
