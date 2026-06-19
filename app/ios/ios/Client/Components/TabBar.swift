//
//  TabBar.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 21/01/2024.
//

import SwiftUI

struct TabItem: View {
    @Environment(TabStateHandler.self) private var state
    var item: TabService

    var body: some View {
        let TabIcon = item.systemImage ? Image ( systemName: item.icon ) : Image ( item.icon )
        TabIcon
            .resizable ( )
            .renderingMode ( .template )
            .frame ( width: 20, height: 20 )
    }
}

struct TabBar: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(TabStateHandler.self) private var state
    @Environment(ActiveData.self) private var activeData

    private var theme: LiturgicalTheme {
        if let today = activeData.GetYear ( )?.getDay ( month: CurrentMonth ( ), day: CurrentDay ( ) ) {
            return LiturgicalTheme ( day: today )
        }
        return LiturgicalTheme ( colors: "g" )
    }

    var body: some View {
        let isLightModeWhite = (colorScheme == .light && theme.isWhite)

        VStack {
            HStack {
                ForEach ( TabService.allCases, id: \.self ) { item in
                    Button {
                        self.state.selected = item.rawValue
                    } label: {
                        HStack ( spacing: 10 ) {
                            TabItem ( item: item )
                                .foregroundStyle (
                                    self.state.selected == item.rawValue
                                        ? (isLightModeWhite ? Color.primary : theme.accent)
                                        : .secondary
                                )
                            if self.state.selected == item.rawValue {
                                Text ( item.title )
                                    .font ( .system ( size: 14, weight: .semibold ) )
                                    .foregroundStyle ( isLightModeWhite ? Color.primary : theme.accent )
                            }
                        }
                        .frame (
                            maxWidth: self.state.selected == item.rawValue ? .infinity : 60,
                            maxHeight: 40, alignment: .center
                        )
                        .background (
                            self.state.selected == item.rawValue
                                ? (isLightModeWhite ? Color.white : theme.accentSubtle)
                                : .clear
                        )
                        .clipShape ( Capsule ( ) )
                        .shadow ( color: Color.black.opacity ( (self.state.selected == item.rawValue && isLightModeWhite) ? 0.08 : 0 ), radius: 2, x: 0, y: 1 )
                        .overlay (
                            Capsule ( )
                                .stroke ( Color.secondary.opacity ( 0.2 ), lineWidth: (self.state.selected == item.rawValue && isLightModeWhite) ? 1 : 0 )
                        )
                    }
                }
            }
            .frame ( maxWidth: .infinity, maxHeight: 50 )
        }
            .padding ( [ .trailing, .leading ], 20 )
            .padding ( .bottom, 10 )
    }
}
