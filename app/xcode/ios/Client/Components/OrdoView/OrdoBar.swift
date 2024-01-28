//
//  InfoBar.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 22/01/2024.
//

import SwiftUI

struct OrdoBar: View {
    @EnvironmentObject var activeData: ActiveData

    @Binding var searchIsActive: Bool
    @Binding var search: String
    @Binding var year: Int
    
    var proxy: ScrollViewProxy

    var body: some View {
        HStack {
            if CurrentYear ( ) == self.year && self.search == "" && !searchIsActive {
                Button ( "Go To Today" ) {
                    DispatchQueue.main.async {
                        proxy.scrollTo ( self.activeData.GetIDToday ( ), anchor: .top )
                    }
                }
                    .bold ( )
                    .foregroundColor ( .blue )
                Text ( " | " )
            }
            Text ( "Year: \( String ( self.year ) )" )
            Text ( " | " )
            Text ( "Version: \( Bundle.main.infoDictionary? [ "CFBundleShortVersionString" ] as? String ?? "Not Found" )" )
        }
            .font ( .footnote )
            .frame ( maxWidth: .infinity, alignment: .center )
            .padding ( [ .vertical ], 8 )
            .background ( Color ( .systemGray6 ) )
            .foregroundColor ( .secondary )
    }
}
