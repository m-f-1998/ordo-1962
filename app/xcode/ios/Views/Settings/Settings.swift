//
//  SettingsView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 10/05/2023.
//

import SwiftUI
import AlertToast

struct Settings: View {
    @State private var ical_res: iCalResult = iCalResult ( state: .not_showing ) // Result of Exporting Calendar
    @Binding var selected_tab: Int
    @EnvironmentObject var net: NetworkMonitor

    var body: some View {
        NavigationStack {
            List {
                Options ( selected_tab: self.$selected_tab )
                    .disabled ( !self.net.connected )
                iCal ( res: self.$ical_res )
                Mail ( )
                Link ( "Privacy Policy", destination: URL ( string: "https://matthewfrankland.co.uk/ordo-1962/v1.1.1/support/privacy.html" )! )
                NavigationLink ( destination:  AppReleases ( ) ) {
                    Text ( "App Release Information" )
                }
            }
                .navigationTitle ( "Settings" )
                .navigationBarTitleDisplayMode ( .inline )
                .toast ( isPresenting: .constant ( self.ical_res.state == .loading ) ) {
                    return AlertToast ( type: .loading )
                }
                .toast ( isPresenting: .constant ( self.ical_res.state == .success ) ) {
                    return AlertToast ( type: .complete ( .green ), title: self.ical_res.data )
                }
                .toast ( isPresenting: .constant ( self.ical_res.state == .failure ) ) {
                    return AlertToast ( type: .error ( .red ), title: self.ical_res.data )
                }
        }
    }
}
