//
//  Row.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import SwiftUI

struct Row: View {
    let feast: CelebrationData
    let month: String

    @State private var menu_expanded: Bool = false

    var body: some View {
        LazyVStack {
            HStack {
                Day ( feast_date: self.feast.date, month: self.month )
                LazyVStack ( alignment: .leading ) {
                    Feast ( data: self.feast.celebrations )
                    ScrollView ( .horizontal, showsIndicators: false ) {
                        Tag (
                            title: self.feast.season.title,
                            colors: self.feast.season.colors.components ( separatedBy: "," ).map {
                                Color ( word: $0 )!.opacity ( 0.5 )
                            }
                        )
                        .padding ( [ .trailing, .leading ], 2 )
                    }
                }
                Image ( systemName: self.menu_expanded ? "chevron.up.circle" : "chevron.down.circle" )
                    .frame ( maxWidth: 20, maxHeight: 20 )
            }
            .contentShape ( Rectangle ( ) )
            .onTapGesture {
                self.menu_expanded.toggle ( )
            }
            if self.menu_expanded {
                    let columns: [ GridItem ] = Array ( repeating: .init ( .flexible ( ) ), count: 2 )
                    LazyVGrid ( columns: columns ) {
                            ForEach ( self.feast.celebrations, id: \.id ) {
                                if let propers = $0.propers {
                                    PropersButton ( content: propers, season: self.feast.season.title, feast_title: $0.title )
                                } else {
                                    HStack {
                                        Text ( "Mass Propers are Unavailable Today" )
                                            .multilineTextAlignment ( .center )
                                    }
                                    .frame ( maxWidth: .infinity, alignment: .center )
                                }
                            }
                    }
                    .frame ( maxWidth: .infinity, alignment: .center )
                    .padding ( [ .top ], 10 )
                    .buttonStyle ( PlainButtonStyle ( ) )
            }
        }
    }
}
