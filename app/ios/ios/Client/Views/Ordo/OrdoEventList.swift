//
//  OrdoEventList.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 23/01/2024.
//

import SwiftUI

struct OrdoEventList: View, KeyboardReadable {
    @EnvironmentObject var activeData: ActiveData
    @Binding var search: String
    @Binding var year: Int
    @State private var isKeyboardVisible = false

    var searchResults: [ [ OrdoDay ] ] {
        if search.isEmpty {
            return self.activeData.GetYear ( year: self.year )!.ordo
        } else {
            return self.activeData.GetFilteredOrdo ( search: self.search, year: self.year )
        }
    }

    var body: some View {
        List {
            ForEach ( searchResults, id: \.self ) { month in
                Section ( header: Spacer ( minLength: 0 ) ) {
                    ForEach ( month ) { day in
                        VStack {
                            NavigationLink {
                                DisplayPropers ( celebrations: day.celebrations.filter { $0.propers.count > 0 } )
                            } label: {
                                OrdoRow ( feast: day, year: String ( self.year ) )
                            }
                                .id ( UUID ( ) )
                        }
                            .id ( "\(day.date.combined)" )
                            .padding ( [ .vertical ], 8 )
                            .disabled ( isKeyboardVisible )
                    }
                }
                    .id ( month [ 0 ].date.month )
                    .onReceive ( keyboardPublisher ) { newIsKeyboardVisible in
                        isKeyboardVisible = newIsKeyboardVisible
                    }
            }
        }
            .overlay {
                if self.searchResults.isEmpty, !self.search.isEmpty {
                    ContentUnavailableView.search ( text: self.search )
                }
            }
    }
}
