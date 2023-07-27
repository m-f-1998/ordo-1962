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
    @EnvironmentObject var propers: PropersAPI

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
            if case let .success ( res ) = self.propers.res {
                if res [ self.month ]! [ self.index ].introit != nil {
                    Image ( systemName: self.menu_expanded ? "chevron.up.circle" : "chevron.down.circle" )
                        .frame ( width: 24, height: 24 )
                        .onTapGesture {
                            self.menu_expanded.toggle ( )
                        }
                }
            }
        }
        if self.menu_expanded {
            if case let .success ( res ) = self.propers.res {
                HStack {
                    VStack {
                        PropersButton ( title: "INTROIT", content: res [ self.month ]! [ self.index ].introit )
                        PropersButton ( title: "COLLECT", content: res [ self.month ]! [ self.index ].collect )
                        PropersButton ( title: "EPISTLE", content: res [ self.month ]! [ self.index ].epistle )
                        PropersButton ( title: "GRADUAL", content: res [ self.month ]! [ self.index ].gradual )
                        PropersButton ( title: "GOSPEL", content: res [ self.month ]! [ self.index ].gospel )
                    }
                    
                    VStack {
                        PropersButton ( title: "OFFERTORY", content: res [ self.month ]! [ self.index ].offertory )
                        PropersButton ( title: "SECRET", content: res [ self.month ]! [ self.index ].secret )
                        PropersButton ( title: "PREFACE", content: res [ self.month ]! [ self.index ].preface )
                        PropersButton ( title: "COMMUNION", content: res [ self.month ]! [ self.index ].communion )
                        PropersButton ( title: "POSTCOMMUNION", content: res [ self.month ]! [ self.index ].postcommunion )
                    }
                }
                    .frame ( maxWidth: .infinity, alignment: .center )
                    .buttonStyle ( PlainButtonStyle ( ) )
            }
        }
    }
}
