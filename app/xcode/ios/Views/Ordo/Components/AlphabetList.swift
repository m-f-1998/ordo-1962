//
//  AlphabetList.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 27/07/2023.
//

import SwiftUI

struct AlphabetList: View {
    var proxy: ScrollViewProxy
    var data: OrdoData

    @State private var dragLocation: CGPoint = .zero
    @Binding var id: Int

    var body: some View {
        VStack ( spacing: 2 ) {
            let months: [ String ] = Calendar.current.monthSymbols.filter { word in
                return self.data [ word ] != nil && self.data [ word ]!.count > 0
            }
            ForEach ( 0..<months.count, id: \.self ) { idx in
                Text ( "\( String ( months [ idx ].prefix ( 3 ) ) )\( idx != months.count-1 ? "\n\u{2022}" : "" )" )
                    .font ( .system ( size: 12 ) )
                    .multilineTextAlignment ( .center )
                    .background (
                        GeometryReader { geo in
                            dragObserver ( geometry: geo, idx: idx, months: months, proxy: proxy )
                        }
                    )
                    .foregroundColor ( .blue )
            }
        }
            .frame ( maxWidth: 24, alignment: .trailing )
            .gesture (
                DragGesture ( minimumDistance: 0, coordinateSpace: .global ).onChanged { value in
                    self.dragLocation = value.location
                }
            )
            .padding ( [ .trailing ], 8 )
    }
    
    private func dragObserver ( geometry: GeometryProxy, idx: Int, months: [String], proxy: ScrollViewProxy ) -> some View {
        if geometry.frame ( in: .global ).contains ( self.dragLocation ) {
            DispatchQueue.main.async {
                if idx != self.id {
                    UIImpactFeedbackGenerator ( style: .soft ).impactOccurred ( )
                    self.id = idx
                    self.dragLocation = .zero
                }
                proxy.scrollTo ( months [ idx ], anchor: .top )
            }
        }
        return Color.clear
    }
}
