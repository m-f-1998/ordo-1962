//
//  OrdoView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 19/04/2023.
//

import SwiftUI

struct NavBarGradient: ViewModifier {
    
    init(from: UIColor, to: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .clear
        
        let imageRenderer = UIGraphicsImageRenderer(size: .init(width: 1, height: 1))
        let gradientImage : UIImage = imageRenderer.image { ctx in
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = imageRenderer.format.bounds
            gradientLayer.colors = [from.cgColor, to.cgColor]
            gradientLayer.locations = [0, 1]
            gradientLayer.startPoint = .init(x: 0.0, y: 0.0)
            gradientLayer.endPoint = .init(x: 0.5, y: 1.0)
            
            gradientLayer.render(in: ctx.cgContext)
        }
        appearance.backgroundImage = gradientImage
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    func body(content: Content) -> some View {
        content
    }
    
}

extension View {
    func navBarGradient(from: UIColor = .systemRed, to: UIColor = .systemYellow) -> some View {
        modifier(NavBarGradient(from: from, to: to))
    }
}

struct Ordo: View {
    var data: OrdoData = DUMMY_ORDO

    @EnvironmentObject var ordo: OrdoAPI
    @EnvironmentObject var propers: PropersAPI
    @Binding var search_text: String

    @State private var dragLocation: CGPoint = .zero
    @State var id: Int = Calendar.current.dateComponents ( [ .month ], from: .now ).month! - 1

    var body: some View {
        ScrollViewReader { proxy in
            NavigationStack {
                ZStack {
                    List ( Calendar.current.monthSymbols, id: \.self ) { month in
                        if ( Array ( self.data [ month ]!.enumerated ( ) ).count > 0 ) {
                            Section ( header: Spacer ( minLength: 0 ) ) {
                                ForEach ( Array ( self.data [ month ]!.enumerated ( ) ), id: \.element.id ) { index, feast in
                                    if case .loading = ordo.res {
                                        Row ( feast: feast, propers_index: index, date: "\(feast.date) \(month) \(UserDefaults.standard.string ( forKey: "year" )!)", month: month )
                                            .padding ( [ .top, .bottom ], 8 )
                                            .redacted ( reason: .placeholder )
                                    } else {
                                        Row ( feast: feast, propers_index: index, date: "\(feast.date) \(month) \(UserDefaults.standard.string ( forKey: "year" )!)", month: month )
                                            .padding ( [ .top, .bottom ], 8 )
                                    }
                                }
                                .animation ( .easeInOut ( duration: 4.0 ), value: 1.0 )
                            }
                        }
                    }
                    .scrollIndicators ( .hidden )
                    .safeAreaInset ( edge: .trailing ) {
                        EmptyView ( ).frame ( width: 13 )
                    }
                    .safeAreaInset ( edge: .bottom ) {
                        EmptyView ( ).frame ( height: 60 )
                    }
                    .onChange ( of: ordo.res ) { res in
                        if case let .success ( ordo_data ) = res {
                            if UserDefaults.standard.string ( forKey: "year" )! == CurrentYear ( ) {
                                self.id = Calendar.current.dateComponents ( [ .month ], from: .now ).month! - 1
                                proxy.scrollTo ( ordo_data [ CurrentMonth ( ) ]! [ CurrentDay ( ) ].id, anchor: .top )
                            }
                        }
                    }
                    .searchable ( text: $search_text )

                    VStack ( spacing: 0 ) {
                        let months: [ String ] = Calendar.current.monthSymbols.filter { word in
                            return data [ word ]!.count > 0
                        }
                        ForEach ( 0..<months.count, id: \.self ) { idx in
                            Text ( "\(String(months [ idx ].prefix(3)))\(idx != months.count-1 ? "\n\u{2022}" : "")" )
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
                    .frame ( maxWidth: .infinity, alignment: .trailing )
                    .padding( [ .trailing ], 7 )
                    .gesture (
                        DragGesture ( minimumDistance: 0, coordinateSpace: .global ).onChanged { value in
                            self.dragLocation = value.location
                        }
                    )
                }
                .navigationTitle ( "1962 Liturgical Ordo" )
                .navBarGradient ( from: UIColor ( .blue.opacity ( 0.3 ) ), to: UIColor ( .green.opacity ( 0.5 ) ) )
            }
            .safeAreaInset ( edge: .bottom ) {
                VStack ( spacing: 0 ) {
                    HStack ( spacing: 30 ) {
                        ToolBar ( data: self.data, proxy: proxy )
                    }
                        .frame ( maxWidth: .infinity )
                    Text ( "Year: \( UserDefaults.standard.string ( forKey: "year" ) ?? "2023" )" )
                        .font ( .system ( .caption ) )
                        .padding ( [ .bottom ], 10 )
                }
                .background ( LinearGradient ( ).overlay ( .ultraThinMaterial ) )
            }
        }
        .task {
            await propers.Update ( )
        }
    }

    private func dragObserver ( geometry: GeometryProxy, idx: Int, months: [String], proxy: ScrollViewProxy ) -> some View {
        if geometry.frame ( in: .global ).contains ( dragLocation ) {
            DispatchQueue.main.async {
                if ( idx != self.id ) {
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
