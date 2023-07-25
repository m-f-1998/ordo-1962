//
//  NavBarView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI

struct ToolBarButton<Content: View>: View {
    @State private var showing_sheet = false
    let image: String
    let content: ( Binding<Bool> ) -> Content

    var body: some View {
        Button {
            self.showing_sheet.toggle ( )
        } label: {
            Image ( systemName: image )
                .frame ( width: 44, height: 44 )
        }.sheet ( isPresented: $showing_sheet ) {
            content ( $showing_sheet )
        }
            .frame ( width: 44, height: 44 )
    }
}

struct ToolBar: View { // The top navigation bar with settings buttons
    let year: String = UserDefaults.standard.string ( forKey: "year" )! // TODO: Move To NavBar
    let data: OrdoData
    let proxy: ScrollViewProxy
    @EnvironmentObject var ordo: OrdoAPI

    var body: some View {
        if case .success = ordo.res {
            HStack {
                ToolBarButton ( image: "book" ) { _ in
                    Prayer ( )
                }
                Divider ( )
                if ( year == CurrentYear ( ) ) {
                    Button {
//                        withAnimation {
                            proxy.scrollTo ( data [ CurrentMonth ( ) ]! [ CurrentDay ( ) - 1 ].id, anchor: .top )
//                        }
                    } label: {
                        HStack {
                            Image ( systemName: "arrow.up.arrow.down" )
                            Text ( "Go To Today" )
                                .scaledFont ( size: 14 )
                        }
                    }
                    Divider ( )
                }
                ToolBarButton ( image: "gear" ) { sheet_showing in
                    Settings ( open_tab: sheet_showing, proxy: proxy )
                }
                Divider ( )
                ToolBarButton ( image: "info.circle" ) { _ in
                    AppReleases ( )
                }
            }
            .frame ( maxWidth: .infinity, maxHeight: 44 )
        }
    }
}
