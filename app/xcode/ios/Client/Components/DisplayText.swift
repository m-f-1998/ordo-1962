//
//  TextDisplay.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/07/2023.
//

import SwiftUI

struct DisplayText: View {
    var text: String

    var body: some View {
        GeometryReader { proxy in
            ScrollView ( .vertical, showsIndicators: false ) {
                Text ( try! AttributedString ( markdown: "\n" + self.text + "\n", options: .init ( interpretedSyntax: .inlineOnlyPreservingWhitespace ) ) )
                    .lineSpacing ( 10 )
                    .font ( .system ( .body, design: .monospaced ) )
                    .frame(minHeight: proxy.size.height)
            }
                .multilineTextAlignment ( .center )
                .frame ( maxWidth: .infinity, maxHeight: proxy.size.height )
        }
            .navigationBarTitleDisplayMode ( .inline )
            .padding ( [ .leading, .trailing ], 15 )
    }
}
