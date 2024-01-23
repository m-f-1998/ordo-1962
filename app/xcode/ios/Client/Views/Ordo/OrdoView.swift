//
//  Ordo.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 19/04/2023.
//

import SwiftUI

struct OrdoView: View {
    @EnvironmentObject var activeData: ActiveData
    
    @State var search: String = ""
    @State var first_load: Bool = true
    @State var year: Int = CurrentYear ( )
    @State var searchIsActive = false
 
    var body: some View {
        ScrollViewReader { proxy in
            NavigationStack {
                VStack ( spacing: 0 ) {
                    OrdoEventList ( search: self.$search, year: self.$year )
                    OrdoBar ( searchIsActive: self.$searchIsActive, search: self.$search, year: self.$year, proxy: proxy )
                }
                    .searchable ( text: self.$search, isPresented: $searchIsActive )
                    .scrollDismissesKeyboard ( .immediately )
                    .scrollIndicators ( .hidden )
                    .toolbar {
                        ToolbarItem ( placement: .automatic ) {
                            OrdoToolbar ( proxy: proxy, year: self.$year )
                        }
                        ToolbarItem ( placement: .topBarLeading ) {
                            Text ( "1962 Liturgical Ordo" )
                                .bold ( )
                        }
                    }
                    .onChange ( of: self.search ) { old, new in
                        if new.isEmpty && !searchIsActive {
                            DispatchQueue.main.async {
                                proxy.scrollTo ( "Jan" )
                            }
                        }
                    }
                    .onAppear {
                        if self.first_load {
                            if !( CurrentMonth ( ) == "Jan" && CurrentDay ( ) == 1 ) {
                                DispatchQueue.main.async {
                                    withAnimation {
                                        proxy.scrollTo ( self.activeData.GetIDToday ( ), anchor: .top )
                                    }
                                }
                            }
                            self.first_load = false
                        }
                    }
            }
        }
    }
}
