//
//  OrdoView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 19/04/2023.
//

import SwiftUI

struct Ordo: View {
    var data: OrdoData = DUMMY_ORDO

    @EnvironmentObject var ordo: OrdoAPI
    @EnvironmentObject var propers: PropersAPI

    @State private var dragLocation: CGPoint = .zero
    @State var id: Int = Calendar.current.dateComponents ( [ .month ], from: .now ).month! - 1

    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ZStack {
                    List ( Calendar.current.monthSymbols, id: \.self ) { month in
                        Section ( header: Spacer ( minLength: 0 ) ) {
                            ForEach ( Array ( self.data [ month ]!.enumerated ( ) ), id: \.element.id ) { index, feast in
                                if case .loading = ordo.res {
                                    Row ( feast: feast, propers_index: index, date: "\(feast.date) \(month) \(UserDefaults.standard.string ( forKey: "year" )!)", month: month )
                                        .padding ( [ .top, .bottom ], 8 )
                                        .redacted ( reason: .placeholder )
                                }
                                else {
                                    Row ( feast: feast, propers_index: index, date: "\(feast.date) \(month) \(UserDefaults.standard.string ( forKey: "year" )!)", month: month )
                                        .padding ( [ .top, .bottom ], 8 )
                                }
                            }.animation ( .easeInOut ( duration: 4.0 ), value: 1.0 )
                        }
                    }
                    .scrollIndicators ( .hidden )
                    .safeAreaInset ( edge: .trailing ) {
                        EmptyView ( ).frame ( width: 11 )
                    }
                    .onChange ( of: ordo.res ) { res in
                        if case let .success ( ordo_data ) = res {
                            if UserDefaults.standard.string ( forKey: "year" )! == CurrentYear ( ) {
                                self.id = Calendar.current.dateComponents ( [ .month ], from: .now ).month! - 1
                                proxy.scrollTo ( ordo_data [ CurrentMonth ( ) ]! [ CurrentDay ( ) - 1 ].id, anchor: .top )
                            }
                        }
                    }
                    VStack {
                        ForEach ( 0..<12, id: \.self ) { idx in
                            Text ( "\(Calendar.current.shortMonthSymbols [ idx ])\(idx != 11 ? "\n\u{2022}" : "")" )
                                .font ( .system ( size: 12 ) )
                                .multilineTextAlignment ( .center )
                                .background ( GeometryReader { geo in dragObserver ( geometry: geo, idx: idx, proxy: proxy ) } )
                                .foregroundColor ( .blue )
                        }
                    }
                    .frame ( maxWidth: .infinity, alignment: .trailing )
                    .padding( [ .trailing ], 7 )
                    .gesture (
                        DragGesture ( minimumDistance: 0, coordinateSpace: .global ).onChanged { value in
                            self.dragLocation = value.location
                        }
                    )
                }.safeAreaInset ( edge: .top ) {
                    NavBar ( data: self.data, proxy: proxy )
                }
            }.background ( LinearGradient ( ).overlay ( .ultraThinMaterial ) )
        }.task {
            await propers.Update ( )
        }
    }

    private func dragObserver ( geometry: GeometryProxy, idx: Int, proxy: ScrollViewProxy ) -> some View {
        if geometry.frame ( in: .global ).contains ( dragLocation ) {
            DispatchQueue.main.async {
                if ( idx != self.id ) {
                    UIImpactFeedbackGenerator ( style: .soft ).impactOccurred ( )
                    self.id = idx
                }
                proxy.scrollTo ( Calendar.current.monthSymbols [ idx ], anchor: .top )
            }
        }
        return Color.clear
    }
}
