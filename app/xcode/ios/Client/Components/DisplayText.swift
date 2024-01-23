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
                RenderMarkdown ( text: self.text )
                    .frame ( minHeight: proxy.size.height )
            }
                .multilineTextAlignment ( .center )
                .frame ( maxWidth: .infinity, maxHeight: proxy.size.height )
        }
    }
}
