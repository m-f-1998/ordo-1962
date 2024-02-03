//
//  CommonView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 15/12/2023.
//

import SwiftUI

struct CommonView: View {
    @EnvironmentObject private var tabStateHanlder: TabStateHandler
    @EnvironmentObject var activeData: ActiveData
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
            TabView ( selection: $tabStateHanlder.selected ) {
                OrdoView ( )
                    .tag ( 0 )
                Prayer ( )
                    .tag ( 1 )
                Settings ( current_ordo: self.activeData.GetYear ( )! )
                    .tag ( 2 )
            }
                .tint ( colorScheme == .dark ? .white : .black )
            TabBar ( )
        }
        .background ( LinearGradient ( colors: [ .green.opacity ( 0.5 ), .blue.opacity( 0.3 ) ] )?.ignoresSafeArea ( ) )
    }
}
