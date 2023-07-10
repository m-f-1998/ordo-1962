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
            Text ( self.subtitle ).font ( .title3 )
            VStack ( alignment: .leading, spacing: 10 ) {
                ForEach ( self.points.map ( { "•\t\($0)" } ), id: \.self) { data in
                    Text ( data ).font ( .system ( size: 14 ) )
                }
            }.padding ( [ .leading ], 20 )
        }.padding ( [ .leading ], 20 )
    }
}

// Display Information Related To App Releases
struct AppReleases: View {
    @Binding var open_tab: Bool

    var body: some View {
        NavigationView {
            VStack ( alignment: .leading, spacing: 20 ) {
                Text ( "Release Information" ).font ( .title )
                DataParagraphs ( subtitle: "v1.0", points: [
                    "Ordo Implementation",
                    "Lock Screen Widgets",
                    "Home Screen Widgets",
                    "Basic Prayers",
                    "Options Information for Feasts",
                    "Changable Years"
                ] )
                DataParagraphs ( subtitle: "Future Updates", points: [
                    "Propers of the Mass",
                    "Android Implemntation",
                    "Localization Suport"
                ] )
                Text ( "†JMJ†" )
                    .frame ( maxWidth: .infinity, alignment: .center )
                    .italic ( )
            }
                .frame ( maxHeight: .infinity, alignment: .topLeading )
                .padding ( )
                .navigationBarItems ( trailing: Button {
                    self.open_tab = false
                } label: {
                    Text ( "Done" ).bold ( )
                } )
        }
    }
}
