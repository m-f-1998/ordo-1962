//
//  File.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 23/01/2024.
//

import SwiftUI

struct OrdoToolbar: View {
    var proxy: ScrollViewProxy
    @Binding var year: Int

    var body: some View {
        HStack {
            Menu {
                ForEach ( CurrentYear ( )...CurrentYear ( ) + 5, id: \.self ) { year in
                    if year == self.year {
                        Menu {
                            ForEach ( 0...11, id: \.self ) { index in
                                Button ( Calendar.current.monthSymbols [ index ] ) {
                                    DispatchQueue.main.async {
                                        self.proxy.scrollTo ( Calendar.current.shortMonthSymbols [ index ], anchor: .top )
                                    }
                                }
                            }
                        } label: {
                            Label ( String ( year ), systemImage: "checkmark" )
                        }
                    } else {
                        Button ( String ( year ) ) {
                            self.year = year
                        }
                    }
                }
            } label: {
                Label ( "Change Date", systemImage: "arrow.up.arrow.down" )
            }
            NavigationLink ( destination: InfoView ( ) ) {
                Label ( "Information", systemImage: "info.circle" )
            }
        }
    }
}
