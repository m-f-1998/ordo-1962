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
            VStack {
                Image ( systemName: self.menu_expanded ? "chevron.up.circle" : "chevron.down.circle" )
            }
                .frame ( maxWidth: 36, maxHeight: .infinity )
        }
        .contentShape ( Rectangle ( ) )
        .onTapGesture {
            self.menu_expanded.toggle ( )
        }
        if self.menu_expanded {
            if case let .success ( res ) = self.propers.res {
                let propers = res [ self.month ]! [ self.index ]
                if propers.introit != nil {
                    HStack {
                        LazyVStack {
                            PropersButton ( title: "INTROIT", content: propers.introit )
                            PropersButton ( title: "COLLECT", content: propers.collect )
                            PropersButton ( title: "EPISTLE", content: propers.epistle )
                            PropersButton ( title: "GRADUAL", content: propers.gradual )
                            PropersButton ( title: "GOSPEL", content: propers.gospel )
                        }

                        LazyVStack {
                            PropersButton ( title: "OFFERTORY", content: propers.offertory )
                            PropersButton ( title: "SECRET", content: propers.secret )
                            PropersButton ( title: "PREFACE", content: propers.preface )
                            PropersButton ( title: "COMMUNION", content: propers.communion )
                            PropersButton ( title: "POSTCOMMUNION", content: propers.postcommunion )
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
            } else if case .loading = self.propers.res {
                HStack {
                    ProgressView ( )
                }
                    .frame ( maxWidth: .infinity, alignment: .center )
            }
        }
    }
}
