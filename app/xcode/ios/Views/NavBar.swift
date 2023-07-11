//
//  NavBarView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI

struct SheetButton<Content: View>: View {
    @State private var showing_sheet = false
    let image: String
    let content: ( Binding<Bool> ) -> Content

    var body: some View {
        Button {
            self.showing_sheet.toggle ( )
        } label: {
            Image ( systemName: image ).frame ( width: 32, height: 32 )
        }.sheet ( isPresented: $showing_sheet ) {
            content ( $showing_sheet )
        }
    }
}

struct NavBar: View { // The top navigation bar with settings buttons
    let year: String = UserDefaults.standard.string ( forKey: "year" )!
    let data: OrdoData
    let proxy: ScrollViewProxy
    let title: String = "Liturgical Ordo", subtitle = "1962 Missale Romanum"
    @EnvironmentObject var ordo: OrdoAPI

    var body: some View {
        LazyVStack ( spacing: 8 ) {
            Text ( "\(self.title) (\(self.year))" )
                .font ( .title )
                .bold ( )
            Text ( self.subtitle )
                .font ( .caption )
                .italic ( )
            if case .success = ordo.res {
                LazyHStack {
                    SheetButton ( image: "book" ) { sheet_showing in
                        Prayer ( open_tab: sheet_showing )
                    }
                    Divider ( )
                    if ( year == "2023" ) {
                        Button {
                            withAnimation {
                                proxy.scrollTo ( data [ CurrentMonth ( ) ]! [ CurrentDay ( ) - 1 ].id, anchor: .top )
                            }
                        } label: {
                            HStack {
                                Image ( systemName: "arrow.up.arrow.down" )
                                Text ( "Go To Today" )
                                    .scaledFont ( size: 14 )
                            }
                        }
                        Divider ( )
                    }
                    SheetButton ( image: "gear" ) { sheet_showing in
                        Settings ( open_tab: sheet_showing, proxy: proxy )
                    }
                    Divider ( )
                    SheetButton ( image: "info.circle" ) { sheet_showing in
                        AppReleases ( open_tab: sheet_showing )
                    }
                }
            }
        }
    }
}
