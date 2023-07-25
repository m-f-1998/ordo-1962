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
            .frame ( maxWidth: .infinity )
    }
}

struct ToolBar: View { // The top navigation bar with settings buttons
    let year: String = UserDefaults.standard.string ( forKey: "year" )! // TODO: Move To NavBar
    let data: OrdoData
    let proxy: ScrollViewProxy
    @EnvironmentObject var ordo: OrdoAPI

    var body: some View {
        if case .success = ordo.res {
            ToolBarButton ( image: "book" ) { _ in
                Prayer ( )
            }
            if ( year == CurrentYear ( ) ) {
                Button {
                    DispatchQueue.main.async {
                        withAnimation {
                            proxy.scrollTo ( data [ CurrentMonth ( ) ]! [ CurrentDay ( ) ].id, anchor: .top )
                        }
                    }
                } label: {
                    Image ( systemName: "arrow.up.arrow.down" )
                        .frame ( width: 44, height: 44 )
                }
                .frame ( maxWidth: .infinity )
            }
            ToolBarButton ( image: "gear" ) { sheet_showing in
                Settings ( open_tab: sheet_showing, proxy: proxy )
            }
        }
        ToolBarButton ( image: "info.circle" ) { _ in
            AppReleases ( )
        }
    }
}
