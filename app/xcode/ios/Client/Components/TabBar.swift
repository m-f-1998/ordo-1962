//
//  TabBar.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 21/01/2024.
//

import SwiftUI

struct TabItem: View {
    @EnvironmentObject private var state: TabStateHandler
    var item: TabService
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        let TabIcon = item.systemImage ? Image ( systemName: item.icon ) : Image ( item.icon )
        TabIcon
            .resizable ( )
            .renderingMode ( .template )
            .foregroundColor (
                self.state.SchemeColor ( item: item.rawValue, isDarkMode: self.colorScheme == .dark )
            )
            .frame ( width: 20, height: 20 )
    }
}

struct TabBar: View {
    @EnvironmentObject private var state: TabStateHandler
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            HStack {
                ForEach ( TabService.allCases, id: \.self ) { item in
                    Button {
                        self.state.selected = item.rawValue
                    } label: {
                        HStack ( spacing: 10 ) {
                            TabItem ( item: item )
                            if self.state.selected == item.rawValue {
                                Text ( item.title )
                                    .font ( .system ( size: 14 ) )
                                    .foregroundColor (
                                        self.state.SchemeColor ( item: item.rawValue, isDarkMode: self.colorScheme == .dark )
                                    )
                            }
                        }
                        .frame (
                            maxWidth: self.state.selected == item.rawValue ? .infinity : 60,
                            maxHeight: 40,alignment: .center
                        )
                        .background ( self.state.selected == item.rawValue ? .blue.opacity ( 0.5 ) : .clear )
                        .cornerRadius ( 30 )
                    }
                }
            }
            .frame ( maxWidth: .infinity, maxHeight: 50 )
            .cornerRadius ( 35 )
        }
            .padding ( [ .trailing, .leading ], 20 )
    }
}
