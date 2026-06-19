//
//  WatchDisplayPropers.swift
//  ordo-1962-watch
//
//  Created by Gemini CLI on 18/06/2026.
//

import SwiftUI
import OrderedCollections

struct WatchDisplayPropers: View {
    let celebrations: [ CelebrationData ]
    private var filteredCelebrations: [ CelebrationData ] {
        celebrations.filter { $0.propers.count > 0 }
    }

    @State private var celeb: Int = 0
    @State private var lang: String = UserDefaults.standard.string ( forKey: "propers-lang" ) ?? "English"
    private let languages = [ "English", "Latin" ]

    @State private var propers: OrderedDictionary<String, String> = [ : ]
    
    init ( celebrations: [ CelebrationData ] ) {
        self.celebrations = celebrations
        let filtered = celebrations.filter { $0.propers.count > 0 }
        let initialIndex = filtered.firstIndex { $0.propers.count > 0 } ?? 0
        _celeb = State ( initialValue: initialIndex )
        
        let initialLang = UserDefaults.standard.string ( forKey: "propers-lang" ) ?? "English"
        _lang = State ( initialValue: initialLang )
        
        if initialIndex < filtered.count {
            _propers = State ( initialValue: filtered [ initialIndex ].GetPropers ( lang: initialLang ) )
        }
    }

    private func switchLanguage ( ) {
        let newLang = lang == "English" ? "Latin" : "English"
        lang = newLang
        UserDefaults.standard.set ( newLang, forKey: "propers-lang" )
        updatePropers ( )
    }

    private func updatePropers ( ) {
        let filtered = filteredCelebrations
        if celeb < filtered.count {
            propers = filtered [ celeb ].GetPropers ( lang: lang )
        }
    }

    var body: some View {
        VStack ( spacing: 0 ) {
            // Header Language Switcher
            HStack {
                if filteredCelebrations.count > 1 {
                    Picker ( "Feast", selection: $celeb ) {
                        ForEach ( Array ( filteredCelebrations.enumerated ( ) ), id: \.offset ) { index, element in
                            Text ( element.title ).tag ( index )
                        }
                    }
                    .onChange ( of: celeb ) { _, _ in
                        updatePropers ( )
                    }
                    .labelsHidden()
                    .pickerStyle ( .navigationLink )
                }
                
                Spacer ( )
                
                Button ( action: switchLanguage ) {
                    Text ( lang == "English" ? "EN" : "LA" )
                        .font ( .system ( size: 11, weight: .bold ) )
                        .padding ( .horizontal, 8 )
                        .padding ( .vertical, 4 )
                        .background ( Color.white.opacity ( 0.15 ) )
                        .clipShape ( RoundedRectangle ( cornerRadius: 4 ) )
                }
                .buttonStyle ( .plain )
            }
            .padding ( .horizontal, 8 )
            .padding ( .bottom, 4 )

            ScrollView ( .vertical, showsIndicators: true ) {
                VStack ( alignment: .leading, spacing: 12 ) {
                    if propers.isEmpty {
                        Text ( "No propers available for this day." )
                            .font ( .footnote )
                            .foregroundStyle ( .secondary )
                            .padding ( )
                            .frame ( maxWidth: .infinity, alignment: .center )
                    } else {
                        ForEach ( Array ( propers.keys ), id: \.self ) { title in
                            VStack ( alignment: .leading, spacing: 4 ) {
                                Text ( title.uppercased ( ) )
                                    .font ( .system ( size: 11, weight: .bold, design: .serif ) )
                                    .foregroundStyle ( Color ( red: 0.85, green: 0.15, blue: 0.15 ) )
                                    .tracking ( 1.0 )
                                
                                Divider ( )
                                    .background ( Color ( red: 0.85, green: 0.15, blue: 0.15 ).opacity ( 0.25 ) )
                                
                                Text (
                                    ( try? AttributedString (
                                        markdown: propers [ title ] ?? "",
                                        options: .init ( interpretedSyntax: .inlineOnlyPreservingWhitespace )
                                    ) ) ?? AttributedString ( propers [ title ] ?? "" )
                                )
                                .font ( .system ( size: 12, design: .serif ) )
                                .multilineTextAlignment ( .leading )
                                .lineSpacing ( 4 )
                                .padding ( .top, 2 )
                            }
                            .padding ( 8 )
                            .background ( Color.white.opacity ( 0.05 ) )
                            .clipShape ( RoundedRectangle ( cornerRadius: 8 ) )
                        }
                    }
                }
                .padding ( .horizontal, 4 )
            }
        }
        .navigationTitle ( "Propers" )
        .onAppear {
            updatePropers ( )
        }
    }
}
