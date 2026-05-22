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
            // Deep parchment-dark background
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
                    Color ( red: 0.72, green: 0.56, blue: 0.16 ).opacity ( 0.18 ),
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
                    // Frosted glass card
                    RoundedRectangle ( cornerRadius: 36 )
                        .fill ( .ultraThinMaterial )
                        .frame ( width: 180, height: 200 )
                        .overlay (
                            RoundedRectangle ( cornerRadius: 36 )
                                .stroke (
                                    LinearGradient (
                                        colors: [
                                            Color ( red: 0.96, green: 0.88, blue: 0.72 ).opacity ( 0.50 ),
                                            Color.white.opacity ( 0.08 )
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1.5
                                )
                        )
                        .shadow ( color: Color ( red: 0.72, green: 0.56, blue: 0.16 ).opacity ( 0.30 ), radius: 40, y: 12 )

                    Image ( "christian-cross" )
                        .resizable ( )
                        .renderingMode ( .template )
                        .scaledToFit ( )
                        .frame ( width: 88, height: 107 )
                        .foregroundStyle (
                            LinearGradient (
                                colors: [
                                    Color ( red: 0.96, green: 0.88, blue: 0.72 ),
                                    Color ( red: 0.72, green: 0.56, blue: 0.16 )
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .shadow ( color: Color ( red: 0.72, green: 0.56, blue: 0.16 ).opacity ( 0.40 ), radius: 12, y: 4 )
                }
                .opacity ( crossOpacity )

                Spacer ( ).frame ( height: 36 )

                // App title with glass treatment
                VStack ( spacing: 6 ) {
                    Text ( "1962 Liturgical Ordo" )
                        .font ( .system ( size: 26, weight: .bold, design: .serif ) )
                        .foregroundStyle (
                            LinearGradient (
                                colors: [
                                    Color ( red: 0.96, green: 0.88, blue: 0.72 ),
                                    Color ( red: 0.85, green: 0.72, blue: 0.50 )
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    Text ( "Traditional Roman Calendar" )
                        .font ( .system ( size: 13, weight: .regular, design: .serif ) )
                        .foregroundStyle ( Color ( red: 0.75, green: 0.70, blue: 0.60 ) )
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
                                .tint ( Color ( red: 0.72, green: 0.56, blue: 0.16 ) )
                                .frame ( width: 180 )
                            Text ( "Downloading \(activeData.percentage)%…" )
                                .font ( .caption )
                                .foregroundStyle ( Color ( red: 0.75, green: 0.70, blue: 0.60 ) )
                        }
                    } else {
                        ProgressView ( )
                            .progressViewStyle ( .circular )
                            .tint ( Color ( red: 0.72, green: 0.56, blue: 0.16 ) )
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
