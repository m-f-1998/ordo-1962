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
    @Environment(\.colorScheme) var colorScheme

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
            TabView ( selection: Bindable ( tabStateHanlder ).selected ) {
                OrdoView ( )
                    .tag ( 0 )
                Prayer ( )
                    .tag ( 1 )
                if let currentYear = activeData.GetYear ( ) {
                    Settings ( current_ordo: currentYear )
                        .tag ( 2 )
                }
            }
                .tint ( colorScheme == .dark ? .white : .black )
            TabBar ( )
        }
    }
}
