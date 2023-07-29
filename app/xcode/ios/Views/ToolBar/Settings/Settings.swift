//
//  SettingsView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 10/05/2023.
//

import SwiftUI
import AlertToast

// 1962 Ordo Settings
struct Settings: View {
    @State private var ical_res: iCalResult = iCalResult ( state: .not_showing )
    @Binding var open_tab: Bool

    var body: some View {
        NavigationStack {
            List {
                Options ( settings_open: self.$open_tab )
                iCal ( res: self.$ical_res )
                Mail ( settings_open: self.$open_tab )
                Link ( "Privacy Policy", destination: URL ( string: "https://matthewfrankland.co.uk/ordo-1962/v1.0/support/privacy.html" )! )
            }
                .navigationTitle ( "Settings" )
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
