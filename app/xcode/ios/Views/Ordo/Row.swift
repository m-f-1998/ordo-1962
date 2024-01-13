//
//  Row.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 11/07/2023.
//

import SwiftUI

struct Row: View {
    let feast: OrdoDay
    let month: String
    let year: String
    @State private var menu_expanded: Bool = false
    
    var rowView: some View {
        HStack {
            let date = self.feast.date, components = date.components ( separatedBy: " " )
            DisplayDate ( day: components [ 0 ], date: components [ 1 ], month: self.month, dateObj: FormatDate ( short: true ).date ( from: "\(date) \(self.month) \(year)" )! )
            VStack ( alignment: .leading ) {
                Feast ( data: self.feast.celebrations )
                ScrollView ( .horizontal, showsIndicators: false ) {
                    Tag (
                        title: self.feast.season.title,
                        colors: self.feast.season.colors.components ( separatedBy: "," ).map {
                            Color ( word: $0 )!
                        }
                    )
                    .padding ( [ .trailing, .leading ], 2 )
                }
            }
        }
    }

    var body: some View {
        if self.feast.celebrations [ 0 ].propers.count == 0 {
            rowView
        } else {
            NavigationLink ( destination: DisplayPropers ( celebrations: self.feast.celebrations ) ) {
                rowView
            }
        }
    }
}

struct SearchRow: View {
    let feast: OrdoDay
    let month: String
    let year: String
    
    var body: some View {
        HStack {
            let date = self.feast.date, components = date.components ( separatedBy: " " )
            let today = Calendar.current.isDateInToday ( FormatDate ( short: true ).date ( from: "\(date) \(month) \(year)" )! )

            VStack {
                Text ( components [ 0 ] )
                Text ( components [ 1 ] )
                    .font ( .system ( size: 24 ) )
                    .bold ( )
                Text ( self.month )
            }
                .frame ( maxWidth: 60, maxHeight: .infinity )
                .font ( .system ( size: 14 ) )
                .padding ( [ .top, .bottom ], 10 )
                .multilineTextAlignment ( .center )
                .background ( today ? LinearGradient ( colors: [ .red, .orange ] ) : LinearGradient ( ) )
                .clipShape ( RoundedRectangle ( cornerRadius: 8 ) )
            VStack ( alignment: .leading ) {
                ForEach ( self.feast.celebrations, id: \.id ) { feast in
                    VStack ( alignment: .leading ) {
                        Text ( feast.title )
                            .font ( .system ( size: 15.0 ) )
                            .bold ( )
                        if feast.commemorations.count > 0 {
                            Text ( "Low Mass Commemorations:" )
                                .font ( .system ( size: 13.0 ) )
                                .padding ( [ .top ], 3 )
                                .bold()
                                .italic()
                        }
                        ForEach ( feast.commemorations, id: \.self ) {
                            Text ( "- \($0.title)" )
                                .font ( .system ( size: 13.0 ) )
                                .padding ( [ .top ], 1 )
                        }
                    }.padding ( [ .bottom ], 5 )
                }
                ScrollView ( .horizontal, showsIndicators: false ) {
                    Tag (
                        title: self.feast.season.title,
                        colors: self.feast.season.colors.components ( separatedBy: "," ).map {
                            Color ( word: $0 )!
                        }
                    )
                    .padding ( [ .trailing, .leading ], 2 )
                }
            }
        }
    }
}
