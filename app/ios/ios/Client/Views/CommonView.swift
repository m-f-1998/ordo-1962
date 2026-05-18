//
//  CommonView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 15/12/2023.
//

import SwiftUI

struct CommonView: View {
    @Environment(TabStateHandler.self) private var tabStateHanlder
    @Environment(ActiveData.self) var activeData

    init ( ) {
        CreateUserDefault ( key: "prayers-lang", value: "English" )
        CreateUserDefault ( key: "propers-lang", value: "English" )
    }
    
    private func CreateUserDefault ( key: String, value: String ) {
        if UserDefaults.standard.string ( forKey: key ) == nil {
            UserDefaults.standard.set ( value, forKey: key )
        }
    }

    var body: some View {
        VStack ( spacing: 0 ) {
            ZStack {
                OrdoView ( )
                    .opacity ( tabStateHanlder.selected == 0 ? 1 : 0 )
                    .allowsHitTesting ( tabStateHanlder.selected == 0 )
                Prayer ( )
                    .opacity ( tabStateHanlder.selected == 1 ? 1 : 0 )
                    .allowsHitTesting ( tabStateHanlder.selected == 1 )
                InfoView ( )
                    .opacity ( tabStateHanlder.selected == 2 ? 1 : 0 )
                    .allowsHitTesting ( tabStateHanlder.selected == 2 )
                if let currentYear = activeData.GetYear ( ) {
                    Settings ( current_ordo: currentYear )
                        .opacity ( tabStateHanlder.selected == 3 ? 1 : 0 )
                        .allowsHitTesting ( tabStateHanlder.selected == 3 )
                }
            }
            .frame ( maxWidth: .infinity, maxHeight: .infinity )
            TabBar ( )
        }
    }
}
