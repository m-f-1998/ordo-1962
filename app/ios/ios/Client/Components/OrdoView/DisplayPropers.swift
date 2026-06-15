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
        
        let initialIndex = celebrations.firstIndex { $0.propers.count > 0 } ?? 0
        _celeb = State ( initialValue: initialIndex )
        _lang = State ( initialValue: lang )
        _propers = State ( initialValue: (initialIndex < celebrations.count ? celebrations [ initialIndex ].GetPropers ( lang: lang ) : [ : ]) )
    }
    
    private func SetLanguage ( new: String ) {
        self.lang = new
        UserDefaults.standard.set ( new, forKey: "propers-lang" )
        if self.celeb < celebrations.count {
            self.propers = celebrations [ self.celeb ].GetPropers ( lang: new )
        }
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
            if new < celebrations.count {
                self.propers = celebrations [ new ].GetPropers ( lang: self.lang )
            }
        }
        .pickerStyle ( .menu )
        .padding ( .vertical, 8 )
        .frame ( maxWidth: .infinity )
        .background ( .ultraThinMaterial )
        .tint ( .primary )
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
        ScrollViewReader { proxy in
            ZStack ( alignment: .bottom ) {
                ScrollView ( .vertical, showsIndicators: false ) {
                    VStack ( spacing: 20 ) {
                        ForEach ( Array ( self.propers.keys ), id: \.self ) { title in
                            VStack ( alignment: .leading, spacing: 8 ) {
                                // Sleek Red Header
                                Text ( title.uppercased ( ) )
                                    .font ( .system ( size: 13, weight: .bold, design: .serif ) )
                                    .foregroundStyle ( Color ( red: 0.65, green: 0.08, blue: 0.08 ) )
                                    .tracking ( 1.2 )
                                    .padding ( .top, 14 )
                                    .padding ( .horizontal, 16 )
                                
                                Divider ( )
                                    .background ( Color ( red: 0.65, green: 0.08, blue: 0.08 ).opacity ( 0.15 ) )
                                    .padding ( .horizontal, 16 )
                                
                                // Sleek left-aligned text content
                                RenderMarkdown ( text: self.propers [ title ] ?? "" )
                                    .padding ( .horizontal, 16 )
                                    .padding ( .bottom, 14 )
                            }
                            .frame ( maxWidth: .infinity, alignment: .leading )
                            .background ( Color ( .secondarySystemBackground ) )
                            .clipShape ( RoundedRectangle ( cornerRadius: 16 ) )
                            .padding ( .horizontal, 16 )
                            .id ( title )
                        }
                    }
                    .padding ( .top, 16 )
                    .padding ( .bottom, celebrations.count > 1 ? 80 : 40 )
                }
                .multilineTextAlignment ( .center )
                .toolbar {
                    ToolbarItem ( placement: .automatic ) {
                        Toolbar ( scroll: proxy )
                    }
                }
                
                if celebrations.count > 1 {
                    PickCelebration ( )
                }
            }
        }
        .navigationBarTitleDisplayMode ( .inline )
    }
}
