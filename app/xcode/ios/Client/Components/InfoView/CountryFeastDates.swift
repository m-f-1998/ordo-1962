//
//  CountryFeastDates.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 28/01/2024.
//

import SwiftUI

struct CountryFeastDates: View {
    var country: String
    @EnvironmentObject var activeData: ActiveData

    var body: some View {
        NavigationLink {
            ScrollViewReader { proxy in
                List {
                    ForEach ( Array ( self.activeData.GetDioceses ( country: country ) ), id: \.self ) { diocese in
                        Section ( header: Text ( diocese ) ) {
                            ForEach ( self.activeData.GetDioceseLocale ( country: country, diocese: diocese ), id: \.self ) { feast in
                                LocalFeast ( data: feast )
                            }
                        }.id ( diocese )
                    }
                }.toolbar {
                    Menu {
                        ForEach ( Array ( self.activeData.GetDioceses ( country: country ) ), id: \.self ) { diocese in
                            Button ( diocese ) {
                                DispatchQueue.main.async {
                                    proxy.scrollTo ( diocese, anchor: .top )
                                }
                            }
                        }
                    } label: {
                        Label ( "Change Date", systemImage: "arrow.up.arrow.down" )
                    }
                }
            }
        } label: {
            Text ( country )
        }
    }
}
