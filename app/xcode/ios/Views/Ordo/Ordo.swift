//
//  OrdoView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 19/04/2023.
//

import SwiftUI

struct PropersButton: View {
    @State private var showing_sheet = false
    let title: String, content: String

    var body: some View {
        Button {
            self.showing_sheet.toggle ( )
        } label: {
            Text ( self.title ).padding ( 6 )
        }
            .sheet ( isPresented: $showing_sheet ) {
                PrayerView ( text: self.content, title: self.title, open_tab: self.$showing_sheet )
            }
            .background ( LinearGradient ( ) )
            .cornerRadius ( 10 )
    }
}

struct Row: View { // Entire Row for a given Feat Day
    let feast: CelebrationData
    let date, month: String
    let current_date: String = FormatDate ( short: true ).string ( from: .now )
    
    @State var menu_expanded: Bool = false

    var body: some View {
        VStack {
            HStack {
                Day ( date: feast.date, month: month ).foregroundColor ( self.current_date == self.date ? .red : nil )
                LazyVStack ( alignment: .leading ) {
                    Feast ( data: self.feast.celebration, font: 16.0 )
                    if self.feast.commemoration.count > 0 {
                        Feast ( data: self.feast.commemoration, font: 13.0, comm: true )
                    }
                    Text ( self.feast.options )
                        .font ( .system ( size: 12 ) )
                        .frame ( maxWidth: .infinity, alignment: .leading )
                        .padding ( [ .top ], 2 )
                    ScrollView ( .horizontal, showsIndicators: false ) {
                        HStack {
                            Tag (
                                title: self.feast.season.title,
                                colors: self.feast.season.colors.map {
                                    Color ( word: $0 )!.opacity ( 0.5 )
                                }
                            )
                            Tag ( title: "Class \(self.feast.celebration [ 0 ].rank)", colors: [ .green.opacity ( 0.3 ), .blue.opacity ( 0.5 ) ] )
                        }.padding ( [ .top, .bottom ], 5 )
                    }
                }
                Image ( systemName: menu_expanded ? "chevron.up" : "chevron.down" )
                    .resizable ( )
                    .frame ( width: 13, height: 6 )
            }.onTapGesture {
                menu_expanded.toggle ( )
            }
            if ( menu_expanded ) {
                HStack {
                    VStack {
                        // TODO: Content
                        PropersButton ( title: "INTROIT", content: "" )
                        PropersButton ( title: "COLLECT", content: "" )
                        PropersButton ( title: "EPISTLE", content: "" )
                        PropersButton ( title: "GRADUAL", content: "" )
                        PropersButton ( title: "GOSPEL", content: "" )
                    }
                        .frame ( maxWidth: .infinity )
                        .font ( .system ( size: 13 ) )
                        .buttonStyle ( PlainButtonStyle ( ) )

                    VStack {
                        PropersButton ( title: "OFFERTORY", content: "" )
                        PropersButton ( title: "SECRET", content: "" )
                        PropersButton ( title: "PREFACE", content: "" )
                        PropersButton ( title: "COMMUNION", content: "" )
                        PropersButton ( title: "POSTCOMMUNION", content: "" )
                    }
                        .frame ( maxWidth: .infinity )
                        .font ( .system ( size: 13 ) )
                        .buttonStyle ( PlainButtonStyle ( ) )
                }
            }
        }
    }
}

struct Ordo: View {
    var data: OrdoData = DUMMY_ORDO

    @EnvironmentObject var ordo: OrdoAPI
    @State private var dragLocation: CGPoint = .zero
    @State var id: Int = Calendar.current.dateComponents ( [ .month ], from: .now ).month! - 1

    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ZStack {
                    List ( Calendar.current.monthSymbols, id: \.self ) { month in
                        Section ( header: Spacer ( minLength: 0 ) ) {
                            ForEach ( self.data [ month ]!, id: \.id ) { feast in
                                if case .loading = ordo.res {
                                    Row ( feast: feast, date: "\(feast.date) \(month) \(UserDefaults.standard.string ( forKey: "year" )!)", month: month )
                                          .padding ( [ .top, .bottom ], 8 )
                                          .redacted ( reason: .placeholder )
                                } else {
                                    Row ( feast: feast, date: "\(feast.date) \(month) \(UserDefaults.standard.string ( forKey: "year" )!)", month: month )
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
