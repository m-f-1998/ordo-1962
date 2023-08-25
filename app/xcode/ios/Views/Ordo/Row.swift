//
//  Row.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import SwiftUI

struct Row: View {
    let feast: CelebrationData
    let index: Int
    let month: String

    @State private var menu_expanded: Bool = false

    var body: some View {
        HStack {
            Day ( feast_date: self.feast.date, month: self.month )
            LazyVStack ( alignment: .leading ) {
                Feast ( data: self.feast.celebrations )
                if let season = self.feast.season {
                    ScrollView ( .horizontal, showsIndicators: false ) {
                        Tag (
                            title: season.title,
                            colors: season.colors.components ( separatedBy: "," ).map {
                                Color ( word: $0 )!.opacity ( 0.5 )
                            }
                        )
                            .padding ( [ .trailing, .leading ], 2 )
                    }
                }
            }
            Image ( systemName: self.menu_expanded ? "chevron.up.circle" : "chevron.down.circle" )
                .resizable ( )
                .frame ( maxWidth: 20, maxHeight: 20 )
        }
        .contentShape ( Rectangle ( ) )
        .onTapGesture {
            self.menu_expanded.toggle ( )
        }
        if self.menu_expanded {
            if let propers = self.feast.propers {
                HStack {
                    LazyVStack {
                        PropersButton ( content: propers, index: 0 )
                        PropersButton ( content: propers, index: 1 )
                        PropersButton ( content: propers, index: 2 )
                        PropersButton ( content: propers, index: 3 )
                        PropersButton ( content: propers, index: 4 )
                    }

                    LazyVStack {
                        PropersButton ( content: propers, index: 5 )
                        PropersButton ( content: propers, index: 6 )
                        PropersButton ( content: propers, index: 7 )
                        PropersButton ( content: propers, index: 8 )
                        PropersButton ( content: propers, index: 9 )
                    }
                }
                .frame ( maxWidth: .infinity, alignment: .center )
                .buttonStyle ( PlainButtonStyle ( ) )
            } else {
                HStack {
                    Text ( "Mass Propers are Unavailable Today" )
                        .multilineTextAlignment ( .center )
                }
                    .frame ( maxWidth: .infinity, alignment: .center )
            }
        }
    }
}
