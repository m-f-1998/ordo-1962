//
//  LoadingView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 07/12/2023.
//

import SwiftUI

struct LoadingView: View {
    @Environment(ActiveData.self) var activeData
    @State private var crossOpacity: Double = 0
    @State private var titleOpacity: Double = 0

    var body: some View {
        ZStack {
            // Deep dark background
            LinearGradient (
                colors: [
                    Color ( red: 0.08, green: 0.06, blue: 0.12 ),
                    Color ( red: 0.13, green: 0.09, blue: 0.18 ),
                    Color ( red: 0.10, green: 0.07, blue: 0.14 )
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea ( )

            // Soft radial glow behind the cross
            RadialGradient (
                colors: [
                    Color.white.opacity ( 0.06 ),
                    Color.clear
                ],
                center: .center,
                startRadius: 20,
                endRadius: 260
            )
            .ignoresSafeArea ( )

            VStack ( spacing: 0 ) {
                Spacer ( )

                // Cross with glass card backdrop
                ZStack {
                    RoundedRectangle ( cornerRadius: 36 )
                        .fill ( .ultraThinMaterial )
                        .frame ( width: 180, height: 200 )
                        .overlay (
                            RoundedRectangle ( cornerRadius: 36 )
                                .stroke (
                                    LinearGradient (
                                        colors: [
                                            Color.white.opacity ( 0.30 ),
                                            Color.white.opacity ( 0.05 )
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1.5
                                )
                        )
                        .shadow ( color: Color.white.opacity ( 0.08 ), radius: 40, y: 12 )

                    Image ( "christian-cross" )
                        .resizable ( )
                        .scaledToFill ( )
                        .frame ( width: 148, height: 168 )
                        .clipShape ( RoundedRectangle ( cornerRadius: 30 ) )
                }
                .opacity ( crossOpacity )

                Spacer ( ).frame ( height: 36 )

                // App title
                VStack ( spacing: 6 ) {
                    Text ( "1962 Liturgical Ordo" )
                        .font ( .system ( size: 26, weight: .bold, design: .serif ) )
                        .foregroundStyle ( Color.white.opacity ( 0.92 ) )
                    Text ( "Traditional Roman Calendar" )
                        .font ( .system ( size: 13, weight: .regular, design: .serif ) )
                        .foregroundStyle ( Color.white.opacity ( 0.50 ) )
                        .tracking ( 1.5 )
                        .textCase ( .uppercase )
                }
                .opacity ( titleOpacity )

                Spacer ( )

                // Loading indicator
                VStack ( spacing: 12 ) {
                    if activeData.downloading {
                        VStack ( spacing: 8 ) {
                            ProgressView ( value: Double ( activeData.percentage ), total: 100 )
                                .progressViewStyle ( .linear )
                                .tint ( Color.white.opacity ( 0.70 ) )
                                .frame ( width: 180 )
                            Text ( "Downloading \(activeData.percentage)%…" )
                                .font ( .caption )
                                .foregroundStyle ( Color.white.opacity ( 0.50 ) )
                        }
                    } else {
                        ProgressView ( )
                            .progressViewStyle ( .circular )
                            .tint ( Color.white.opacity ( 0.70 ) )
                    }
                }
                .opacity ( titleOpacity )
                .padding ( .bottom, 60 )
            }
        }
        .onAppear {
            withAnimation ( .easeOut ( duration: 0.7 ) ) {
                crossOpacity = 1
            }
            withAnimation ( .easeOut ( duration: 0.7 ).delay ( 0.3 ) ) {
                titleOpacity = 1
            }
        }
    }
}
