//
//  DisplayPropers.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 17/12/2023.
//

import SwiftUI
import OrderedCollections

struct DisplayPropers: View {
    @State private var celeb: Int = 0
    var celebrations: [ CelebrationData ] = [ ]

    @State private var lang: String = ""
    var languages: [ String ] = [ "English", "Latin" ]

    @State private var propers: OrderedDictionary<String, String>

    init (
        celebrations: [ CelebrationData ],
        lang: String = UserDefaults.standard.string ( forKey: "propers-lang" ) ?? "English"
    ) {
        self.celebrations = celebrations
        self.lang = lang
        self.propers = celebrations [ 0 ].GetPropers ( lang: lang )
    }
    
    private func SetLanguage ( new: String ) {
        self.lang = new
        UserDefaults.standard.set ( new, forKey: "propers-lang" )
        self.propers = celebrations [ self.celeb ].GetPropers ( lang: new )
    }
    
    private func PickCelebration ( ) -> some View {
        return Picker ( selection: self.$celeb, label: EmptyView ( ) ) {
            ForEach ( Array ( self.celebrations.enumerated ( ) ), id: \.offset ) { index, element in
                if element.propers.count > 0 {
                    Text ( element.title )
                        .tag ( index )
                }
            }
        }
        .onChange ( of: self.celeb ) { old, new in
            self.propers = celebrations [ new ].GetPropers ( lang: self.lang )
        }
        .pickerStyle ( .menu )
        .padding ( [ .vertical ], 4 )
        .frame ( maxWidth: .infinity )
        .background ( Color ( .systemGray6 ) )
        .tint ( .blue )
    }
    
    private func Toolbar ( scroll: ScrollViewProxy ) -> some View {
        return HStack {
            Menu {
                ForEach ( Array ( self.propers.keys ), id: \.self ) { title in
                    Button {
                        scroll.scrollTo ( title, anchor: .top )
                    } label: {
                        Text ( title )
                    }
                }
            } label: {
                Label ( "Go To", systemImage: "arrow.up.arrow.down" )
            }
            Menu {
                ForEach ( self.languages, id: \.self ) { language in
                    Button {
                        SetLanguage ( new: language )
                    } label: {
                        if language == self.lang {
                            Label ( language, systemImage: "checkmark" )
                        } else {
                            Text ( language )
                        }
                    }
                }
            } label: {
                Label ( "Propers Language", systemImage: "character.bubble" )
            }
        }
    }

    var body: some View {
        VStack ( spacing: 0 ) {
            ScrollViewReader { proxy in
                VStack ( spacing: 0 ) {
                    ScrollView ( .vertical, showsIndicators: false ) {
                        ForEach ( Array ( self.propers.keys ), id: \.self ) { title in
                            RenderMarkdown ( text: self.propers [ title ]! )
                            if self.propers.keys.last != title {
                                Divider ( )
                            }
                        }
                    }
                    .multilineTextAlignment ( .center )
                    .toolbar {
                        ToolbarItem ( placement: .automatic ) {
                            Toolbar ( scroll: proxy )
                        }
                    }
                    PickCelebration ( )
                }
            }
        }.navigationBarTitleDisplayMode ( .inline )
    }
}
