//
//  CountryFeastDates.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 28/01/2024.
//

import SwiftUI

struct CountryFeastDates: View {
    var country: String
    @Environment(ActiveData.self) var activeData

    var body: some View {
        NavigationLink {
            ScrollViewReader { proxy in
                ScrollView ( .vertical, showsIndicators: false ) {
                    VStack ( spacing: 8 ) {
                        ForEach ( Array ( self.activeData.GetDioceses ( country: country ) ), id: \.self ) { diocese in
                            SectionHeader ( title: diocese )
                                .id ( diocese )
                            
                            ForEach ( self.activeData.GetDioceseLocale ( country: country, diocese: diocese ), id: \.self ) { feast in
                                LocalFeast ( data: feast )
                            }
                        }
                    }
                    .padding ( .vertical, 16 )
                }
                .toolbar {
                    ToolbarItem ( placement: .topBarTrailing ) {
                        Menu {
                            ForEach ( Array ( self.activeData.GetDioceses ( country: country ) ), id: \.self ) { diocese in
                                Button ( diocese ) {
                                    withAnimation {
                                        proxy.scrollTo ( diocese, anchor: .top )
                                    }
                                }
                            }
                        } label: {
                            Label ( "Change Diocese", systemImage: "arrow.up.arrow.down" )
                        }
                    }
                }
            }
        } label: {
            Text ( country )
        }
    }
}
