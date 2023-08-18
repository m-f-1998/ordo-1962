//
//  Ordo.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 19/04/2023.
//

import SwiftUI

struct Ordo: View {
    @EnvironmentObject var ordo: OrdoAPI
    
    @State private var lang: String = UserDefaults.standard.string ( forKey: "propers-lang" )!
    @State private var go_to_open: Bool = false
    @Binding var search_text: String
    @Binding var selected_tab: Int

    var data: OrdoData = DUMMY_ORDO
    var languages: [ String ] = [ "English", "Latin" ]

    var body: some View {
        ScrollViewReader { proxy in
            NavigationStack {
                VStack ( spacing: 0 ) {
                    HStack ( spacing: 0 ) {
                        Text ( "Year: \(UserDefaults.standard.string ( forKey: "year" ) ?? CurrentYear ( ))" )
                            .bold ( )
                            .italic ( )
                            .padding ( [ .top, .bottom ], 7 )
                            .padding ( [ .leading ], 20 )
                    }
                        .frame ( maxWidth: .infinity, alignment: .leading )
                        .background ( LinearGradient ( colors: [ .orange, .red ] ) )
                    List ( Calendar.current.monthSymbols, id: \.self ) { month in
                        if self.data [ month ]!.count > 0 {
                            Section ( header: Spacer ( minLength: 0 ) ) {
                                ForEach ( 0...self.data [ month ]!.count-1, id: \.self ) { index in
                                    let day = Int ( self.data [ month ]![ index ].date.suffix ( 2 ) )! - 1
                                    Row ( feast: self.data [ month ]![ index ], index: day, month: month )
                                        .padding ( [ .top, .bottom ], 8 )
                                        .redacted ( reason: self.data == DUMMY_ORDO ? .placeholder : [] )
                                        .id ( self.data [ month ]![ index ].id )
                                }
                            }
                        }
                    }
                    .scrollDisabled ( data == DUMMY_ORDO )
                    .scrollIndicators ( .hidden )
                    .navigationTitle ( "1962 Ordo" )
                    .toolbar {
                        ToolbarItem ( placement: .automatic ) {
                            HStack {
                                Menu ( content: {
                                    CustomPicker ( data: self.languages, title: "Propers Language", selected: self.$lang ).onChange ( of: lang ) { change in
                                        UserDefaults.standard.set ( change, forKey: "propers-lang" )
                                    }
                                }, label: { Label ( "Propers Language", systemImage: "character.bubble" ) } )
                                    .disabled ( data == DUMMY_ORDO )
                                NavigationStack {
                                    Button {
                                        self.go_to_open.toggle ( )
                                    } label: {
                                        Image ( systemName: "calendar" )
                                    }
                                    .navigationDestination ( isPresented: self.$go_to_open ) {
                                        GoTo ( data: self.data, proxy: proxy, view_open: self.$go_to_open )
                                    }
                                }
                                    .disabled ( data == DUMMY_ORDO )
                            }
                        }
                    }
                    .searchable ( text: self.$search_text, placement: .navigationBarDrawer ( displayMode: .always ) )
                    .NavBarGradient ( from: .blue.opacity ( 0.3 ), to: .green.opacity ( 0.5 ) )
                }
            }
            .onChange ( of: self.data ) { change in
                // Required for API as On Loading State When Appears
                self.ScrollView ( proxy: proxy, change: change )
            }
            .onAppear {
                // Required for Cache to Run on Load
                self.ScrollView ( proxy: proxy, change: data, onAppear: true )
            }
        }
    }
    
    func ScrollView ( proxy: ScrollViewProxy, change: OrdoData, onAppear: Bool = false ) {
        if change != DUMMY_ORDO {
            if UserDefaults.standard.string ( forKey: "year" ) == CurrentYear ( ) {
                let go_to_today = UserDefaults.standard.integer ( forKey: "go-to-today" )
                if go_to_today != 1 {
                    if let id = self.ordo.GetIDToday ( ) {
                        let queue = go_to_today == 2 ? DispatchQueue.main : DispatchQueue.global ( qos: .default )
                        UserDefaults.standard.set ( 1, forKey: "go-to-today" )
                        queue.async {
                            proxy.scrollTo ( id, anchor: .top )
                        }
                    }
                }
            } else if !onAppear {
                proxy.scrollTo ( "January", anchor: .top )
            }
        }
    }
}
