//
//  CommonView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 15/12/2023.
//

import SwiftUI
class TabStateHandler: ObservableObject {
    @Published var tabSelected: Int = 0
}


struct CommonView: View {
    private let app_url: String = "itms-apps://itunes.apple.com/app/6450934181"
    @StateObject var tabStateHanlder: TabStateHandler = TabStateHandler ( )
    @EnvironmentObject var activeData: ActiveData
    @Environment(\.colorScheme) var colorScheme

    init ( ) {
        if UserDefaults.standard.string ( forKey: "prayers-lang" ) == nil {
            UserDefaults.standard.set ( "English", forKey: "prayers-lang" )
        }
        
        if UserDefaults.standard.string ( forKey: "propers-lang" ) == nil {
            UserDefaults.standard.set ( "English", forKey: "propers-lang" )
        }
    }

    var body: some View {
        VStack ( spacing: 0 ) {
            TabView ( selection: $tabStateHanlder.tabSelected ) {
                OrdoView ( )
                    .tag ( 0 )
                    .toolbar(.hidden, for: .tabBar)
                Prayer ( )
                    .tag ( 1 )
                    .toolbar(.hidden, for: .tabBar)
                Settings ( current_ordo: self.activeData.GetYear ( )! )
                    .tag ( 2 )
                    .toolbar(.hidden, for: .tabBar)
            }
            .tint ( colorScheme == .dark ? .white : .black )
            VStack {
                HStack {
                    ForEach( TabbedItems.allCases, id: \.self){ item in
                        Button {
                            tabStateHanlder.tabSelected = item.rawValue
                        } label: {
                            HStack ( spacing: 10 ) {
                                if item.systemImage {
                                    Image ( systemName: item.icon )
                                        .resizable ( )
                                        .renderingMode ( .template )
                                        .foregroundColor (
                                            tabStateHanlder.tabSelected == item.rawValue ?
                                                ( colorScheme == .dark ? .white : .black )
                                            :
                                                .gray
                                        )
                                        .frame ( width: 20, height: 20 )
                                } else {
                                    Image ( item.icon )
                                        .resizable ( )
                                        .renderingMode ( .template )
                                        .foregroundColor (
                                            tabStateHanlder.tabSelected == item.rawValue ?
                                                ( colorScheme == .dark ? .white : .black )
                                            :
                                                .gray
                                        )
                                        .frame ( width: 20, height: 20 )
                                }
                                if (tabStateHanlder.tabSelected == item.rawValue) {
                                    Text ( item.title )
                                        .font ( .system ( size: 14 ) )
                                        .foregroundColor (
                                            tabStateHanlder.tabSelected == item.rawValue ?
                                                ( colorScheme == .dark ? .white : .black )
                                            :
                                                .gray
                                        )
                                }
                            }
                            .frame ( maxWidth: tabStateHanlder.tabSelected == item.rawValue ? .infinity : 60, maxHeight: 40, alignment: .center )
                            .background ( tabStateHanlder.tabSelected == item.rawValue ? .blue.opacity ( 0.5 ) : .clear )
                            .cornerRadius ( 30 )
                        }
                    }
                }
                .frame ( maxWidth: .infinity, maxHeight: 50 )
                .cornerRadius ( 35 )
            }
            .padding ( [ .trailing, .leading ], 20 )
        }
        .background ( LinearGradient ( colors: [ .green.opacity ( 0.5 ), .blue.opacity( 0.3 ) ] )?.ignoresSafeArea ( ) )
    }
}

enum TabbedItems: Int, CaseIterable {
    case ordo = 0
    case prayer
    case settings
    
    var systemImage: Bool {
        switch self {
            case .prayer:
                return false
            default:
                return true
        }
    }
    
    var title: String {
        switch self {
            case .ordo:
                return "Ordo"
            case .prayer:
                return "Prayer"
            case .settings:
                return "Settings"
        }
    }
    
    var icon: String{
        switch self {
            case .ordo:
                return "calendar"
            case .prayer:
                return "pray"
            case .settings:
                return "gear"
        }
    }
}
