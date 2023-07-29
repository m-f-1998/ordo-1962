//
//  NavBarView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI

// Button Row Shown At Bottom Of Screen
struct ToolBarButton <Content: View>: View {
    var image: String = ""
    var systemImage: String = ""
    @State private var showing_sheet = false
    let content: ( Binding<Bool> ) -> Content

    var body: some View {
        Button {
            self.showing_sheet.toggle ( )
        } label: {
            if image != "" {
                Image ( image )
                    .resizable ( )
                    .scaledToFit ( )
                    .frame ( width: 22, height: 22 )
            } else if systemImage != "" {
                Image ( systemName: systemImage )
            }
        }
            .sheet ( isPresented: $showing_sheet ) {
                content ( $showing_sheet )
            }
            .frame ( maxWidth: .infinity )
            .tint ( .blue )
    }
}

// ToolBar Button Row With Background
struct ToolBar: View {
    private let year: String = UserDefaults.standard.string ( forKey: "year" )!
    let data: OrdoData
    let proxy: ScrollViewProxy
    let search: Bool

    var body: some View {
        HStack ( spacing: 30 ) {
            if self.data != DUMMY_ORDO {
                ToolBarButton ( image: "pray" ) { _ in
                    Prayer ( )
                }
                ToolBarButton ( systemImage: "calendar" ) { sheet_showing in
                    GoTo ( showDatePicker: sheet_showing, data: self.data, proxy: self.proxy )
                }
                ToolBarButton ( systemImage: "gear" ) { sheet_showing in
                    Settings ( open_tab: sheet_showing )
                }
            }
            ToolBarButton ( systemImage: "info.circle" ) { _ in
                AppReleases ( )
            }
        }
            .padding ( )
    }
}
