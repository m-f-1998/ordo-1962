//
//  OrdoView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 15/12/2023.
//

import SwiftUI
class TabStateHandler: ObservableObject {
    @Published var tabSelected: Int = 0 {
        willSet {
            if newValue == tabSelected && tabSelected == 0 {
                moveFirstTabToTop.toggle ( )
            }
        }
    }

    @Published var moveFirstTabToTop: Bool = false
}


struct OrdoView: View {
    private let app_url: String = "itms-apps://itunes.apple.com/app/6450934181"
    @StateObject var tabStateHanlder: TabStateHandler = TabStateHandler ( )
    @EnvironmentObject var activeData: ActiveData

    init ( ) {
        if UserDefaults.standard.string ( forKey: "prayers-lang" ) == nil {
            UserDefaults.standard.set ( "English", forKey: "prayers-lang" )
        }
        
        if UserDefaults.standard.string ( forKey: "propers-lang" ) == nil {
            UserDefaults.standard.set ( "English", forKey: "propers-lang" )
        }
    }

    var body: some View {
        TabView ( selection: $tabStateHanlder.tabSelected ) {
            Ordo ( second_tap: $tabStateHanlder.moveFirstTabToTop )
                .tabItem {
                    Label ( "Ordo", systemImage: "calendar" )
                }
                .tag ( 0 )
            Prayer ( )
                .tabItem {
                    Image ( "pray" )
                    Text ( "Prayer" )
                }
                .tag ( 1 )
            Settings ( current_ordo: self.activeData.GetYear ( )! )
                .tabItem {
                    Label ( "Settings", systemImage: "gear" )
                }
                .tag ( 2 )
        }
            .SetGradient ( from: .blue.opacity ( 0.3 ), to: .green.opacity ( 0.5 ) )
    }
}
