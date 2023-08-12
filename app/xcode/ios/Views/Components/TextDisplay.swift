//
//  TextDisplay.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/07/2023.
//

import SwiftUI

// A Simple Screen To Show Some Text
struct TextDisplay: View {
    var text: String
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView ( .vertical, showsIndicators: false ) {
                Text ( try! AttributedString ( markdown: self.text, options: .init ( interpretedSyntax: .inlineOnlyPreservingWhitespace ) ) )
                    .lineSpacing ( 10 )
                    .frame ( minHeight: proxy.size.height )
                    .font ( .system ( .body, design: .monospaced ) )
                    .padding ( [ .leading, .trailing, .top, .bottom ], 20 )
            }
                .multilineTextAlignment ( .center )
                .frame ( maxWidth: .infinity )
        }
            .navigationBarTitleDisplayMode ( .inline )
    }
}
