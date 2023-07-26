//
//  Ordo.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 19/04/2023.
//

import SwiftUI

struct Ordo: View {
    @EnvironmentObject var propers: PropersAPI

    @State private var dragLocation: CGPoint = .zero
    @State private var id: Int = Calendar.current.dateComponents ( [ .month ], from: .now ).month! - 1
    @Binding var search_text: String

    var data: OrdoData = DUMMY_ORDO

    var body: some View {
        ScrollViewReader { proxy in
            NavigationStack {
                VStack ( spacing: 0 ) {
                    HStack ( spacing: 0 ) {
                        List ( Calendar.current.monthSymbols, id: \.self ) { month in
                            if self.data [ month ]!.count > 0 {
                                Section ( header: Spacer ( minLength: 0 ) ) {
                                    ForEach ( Array ( self.data [ month ]!.enumerated ( ) ), id: \.element.id ) { index, feast in
                                        Row ( feast: feast, index: index, date: "\(feast.date) \(month) \(UserDefaults.standard.string ( forKey: "year" )!)", month: month )
                                                .padding ( [ .top, .bottom ], 8 )
                                                .redacted ( reason: self.data == DUMMY_ORDO ? .placeholder : [] )
                                    }
                                    .animation ( .easeInOut ( duration: 4.0 ), value: 1.0 )
                                }
                            }
                        }
                            .scrollIndicators ( .hidden )
                            .onChange ( of: self.data ) { ordo in
                                if self.search_text == "" && UserDefaults.standard.string ( forKey: "year" )! == CurrentYear ( ) {
                                    self.id = Calendar.current.dateComponents ( [ .month ], from: .now ).month! - 1
                                    proxy.scrollTo ( ordo [ CurrentMonth ( ) ]! [ CurrentDay ( ) - 1 ].id, anchor: .top )
                                }
                            }
                            .searchable ( text: self.$search_text )
                        
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
                    }
                        .navigationTitle ( "1962 Liturgical Ordo" )
                        .NavBarGradient ( from: .blue.opacity ( 0.3 ), to: .green.opacity ( 0.5 ) )
                    
                    VStack ( spacing: 0 ) {
                        HStack ( spacing: 30 ) {
                            ToolBar ( data: self.data, proxy: proxy, search: self.search_text != "" )
                        }
                            .padding ( )
                        Text ( "Year: \( UserDefaults.standard.string ( forKey: "year" ) ?? CurrentYear ( ) )" )
                            .font ( .system ( .caption ) )
                            .padding ( [ .bottom ], 10 )
                    }
                        .background ( LinearGradient ( ).overlay ( .ultraThinMaterial ) )
                }
            }
        }
            .task {
                await self.propers.Update ( )
            }
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
