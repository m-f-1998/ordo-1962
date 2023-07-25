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
        HStack {
            Day ( date: feast.date, month: month ).foregroundColor ( self.current_date == self.date ? .red : nil )
            LazyVStack ( alignment: .leading ) {
                Feast ( data: self.feast.celebrations )
                if let season = self.feast.season {
                    ScrollView ( .horizontal, showsIndicators: false ) {
                        HStack {
                            Tag (
                                title: season.title,
                                colors: season.colors.components ( separatedBy: "," ).map {
                                    Color ( word: $0 )!.opacity ( 0.5 )
                                }
                            )
                        }.padding ( [ .top, .bottom ], 5 )
                    }
                }
            }
            if case let .success ( res ) = propers.res {
                if res [ month ]! [ propers_index ].introit != nil {
                    Image ( systemName: menu_expanded ? "chevron.up" : "chevron.down" )
                        .resizable ( )
                        .frame ( width: 18, height: 9 )
                        .onTapGesture {
                            menu_expanded.toggle ( )
                        }
                }
            }
        }
            .contentShape ( Rectangle ( ) )
        if menu_expanded {
            if case let .success ( propers_res ) = propers.res {
                if propers_res [ month ]! [ propers_index ].introit != nil {
                    HStack {
                        VStack {
                            if let introit = propers_res [ month ]! [ propers_index ].introit {
                                PropersButton ( title: "INTROIT", content: introit )
                            } else {
                                fatalError ( "INTROIT Did Not Appear At Index \(propers_index)" )
                            }
                            if let collect = propers_res [ month ]! [ propers_index ].collect {
                                PropersButton ( title: "COLLECT", content: collect )
                            } else {
                                fatalError ( "COLLECT Did Not Appear At Index \(propers_index)" )
                            }
                            if let epistle = propers_res [ month ]! [ propers_index ].epistle {
                                PropersButton ( title: "EPISTLE", content: epistle )
                            } else {
                                fatalError ( "EPISTLE Did Not Appear At Index \(propers_index)" )
                            }
                            if let gradual = propers_res [ month ]! [ propers_index ].gradual {
                                PropersButton ( title: "GRADUAL", content: gradual )
                            } else {
                                fatalError ( "GRADUAL Did Not Appear At Index \(propers_index)" )
                            }
                            if let gospel = propers_res [ month ]! [ propers_index ].gospel {
                                PropersButton ( title: "GOSPEL", content: gospel )
                            } else {
                                fatalError ( "GOSPEL Did Not Appear At Index \(propers_index)" )
                            }
                        }
                        
                        VStack {
                            if let offertory = propers_res [ month ]! [ propers_index ].offertory {
                                PropersButton ( title: "OFFERTORY", content: offertory )
                            } else {
                                fatalError ( "OFFERTORY Did Not Appear At Index \(propers_index)" )
                            }
                            if let secret = propers_res [ month ]! [ propers_index ].secret {
                                PropersButton ( title: "SECRET", content: secret )
                            } else {
                                fatalError ( "SECRET Did Not Appear At Index \(propers_index)" )
                            }
                            if let preface = propers_res [ month ]! [ propers_index ].preface {
                                PropersButton ( title: "PREFACE", content: preface )
                            } else {
                                fatalError ( "PREFACE Did Not Appear At Index \(propers_index)" )
                            }
                            if let communion = propers_res [ month ]! [ propers_index ].communion {
                                PropersButton ( title: "COMMUNION", content: communion )
                            } else {
                                fatalError ( "COMMUNION Did Not Appear At Index \(propers_index)" )
                            }
                            if let postcommunion = propers_res [ month ]! [ propers_index ].postcommunion {
                                PropersButton ( title: "POSTCOMMUNION", content: postcommunion )
                            } else {
                                fatalError ( "POSTCOMMUNION Did Not Appear At Index \(propers_index)" )
                            }
                        }
                    }
                    .frame ( maxWidth: .infinity, alignment: .center )
                    .buttonStyle ( PlainButtonStyle ( ) )
                }
            }
        }
    }
}
