//
//  Info.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 12/06/2023.
//

import SwiftUI

private struct DataParagraphs: View {
    var subtitle: String
    var points: [ String ]

    var body: some View {
        VStack ( alignment: .leading, spacing: 10 ) {
            Text ( self.subtitle )
                .font ( .title )
                .bold ( )
            VStack ( alignment: .leading ) {
                Text ( self.points.map ( { "\t•\t\($0)" } ).joined ( separator: "\n" ) )
                    .font ( .system ( size: 17, design: .monospaced ) )
                    .lineSpacing ( 10 )
            }
        }.padding ( [ .trailing, .leading, .bottom ], 20 )
    }
}

// Display Information Related To App Releases
struct AppReleases: View {
    var body: some View {
        NavigationStack {
            VStack ( alignment: .leading, spacing: 20 ) {
                DataParagraphs ( subtitle: "v1.0", points: [
                    "Liturgical Ordo",
                    "watchOS & Widget Support",
                    "Prayers",
                    "Propers of the Mass"
                ] )
                DataParagraphs ( subtitle: "Upcoming Features", points: [
                    "Localization",
                    "Votive Masses",
                    "More Prayers",
                    "Languages Options"
                ] )
                Text ( "†JMJ†" )
                    .frame ( maxWidth: .infinity, alignment: .center )
                    .italic ( )
            }
                .navigationTitle ( "App Updates" )
        }
    }
}
