//
//  RenderMarkdown.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 21/01/2024.
//

import SwiftUI

struct RenderMarkdown: View {
    var text: String

    var body: some View {
        Text (
            try! AttributedString (
                markdown: self.text, options: .init ( interpretedSyntax: .inlineOnlyPreservingWhitespace )
            )
        )
            .lineSpacing ( 10 )
            .font ( .system ( .body, design: .monospaced ) )
            .padding ( 20 )
    }
}
