//
//  Row.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import SwiftUI

struct Row: View { // Entire Row for a given Feat Day
    let feast: CelebrationData
    let propers_index: Int

    let date, month: String
    let current_date: String = FormatDate ( short: true ).string ( from: .now )
    
    @State var menu_expanded: Bool = false
    @EnvironmentObject var propers: PropersAPI

    var body: some View {
        VStack {
            HStack {
                Day ( date: feast.date, month: month ).foregroundColor ( self.current_date == self.date ? .red : nil )
                LazyVStack ( alignment: .leading ) {
                    Feast ( data: self.feast.celebration, font: 18.0 )
                    if self.feast.commemoration.count > 0 {
                        Feast ( data: self.feast.commemoration, font: 15.0, comm: true )
                    }
                    Text ( self.feast.options )
                        .scaledFont ( size: 14 )
                        .frame ( maxWidth: .infinity, alignment: .leading )
                        .padding ( [ .top ], 2 )
                    ScrollView ( .horizontal, showsIndicators: false ) {
                        HStack {
                            Tag (
                                title: self.feast.season.title,
                                colors: self.feast.season.colors.components ( separatedBy: "," ).map {
                                    Color ( word: $0 )!.opacity ( 0.5 )
                                }
                            )
                            Tag ( title: "Class \(self.feast.celebration [ 0 ].rank)", colors: [ .green.opacity ( 0.3 ), .blue.opacity ( 0.5 ) ] )
                        }.padding ( [ .top, .bottom ], 5 )
                    }
                }
                if case let .success ( propers_res ) = propers.res {
                    if propers_res [ month ]! [ propers_index ].collect != nil {
                        Image ( systemName: menu_expanded ? "chevron.up" : "chevron.down" )
                            .resizable ( )
                            .frame ( width: 13, height: 6 )
                    }
                }
            }
                .contentShape ( Rectangle ( ) )
                .onTapGesture {
                    if case let .success ( propers_res ) = propers.res {
                        if propers_res [ month ]! [ propers_index ].collect != nil {
                            menu_expanded.toggle ( )
                        }
                    }
                }
            if case let .success ( propers_res ) = propers.res {
                if menu_expanded && propers_res [ month ]! [ propers_index ].collect != nil {
                    HStack {
                        VStack {
                            if propers_res [ month ]! [ propers_index ].introit != nil {
                                PropersButton ( title: "INTROIT", content: propers_res [ month ]! [ propers_index ].introit! )
                            }
                            PropersButton ( title: "COLLECT", content: propers_res [ month ]! [ propers_index ].collect! )
                            PropersButton ( title: "EPISTLE", content: propers_res [ month ]! [ propers_index ].epistle! )
                            PropersButton ( title: "GRADUAL", content: propers_res [ month ]! [ propers_index ].gradual! )
                            PropersButton ( title: "GOSPEL", content: propers_res [ month ]! [ propers_index ].gospel! )
                        }

                        VStack {
                            if propers_res [ month ]! [ propers_index ].offertory != nil {
                                PropersButton ( title: "OFFERTORY", content: propers_res [ month ]! [ propers_index ].offertory! )
                            }
                            PropersButton ( title: "SECRET", content: propers_res [ month ]! [ propers_index ].secret! )
                            PropersButton ( title: "PREFACE", content: propers_res [ month ]! [ propers_index ].preface! )
                            if propers_res [ month ]! [ propers_index ].communion != nil {
                                PropersButton ( title: "COMMUNION", content: propers_res [ month ]! [ propers_index ].communion! )
                            }
                            PropersButton ( title: "POSTCOMMUNION", content: propers_res [ month ]! [ propers_index ].postcommunion! )
                        }
                    }
                        .frame ( maxWidth: .infinity, alignment: .center )
                        .buttonStyle ( PlainButtonStyle ( ) )
                }
            }
        }
    }
}
