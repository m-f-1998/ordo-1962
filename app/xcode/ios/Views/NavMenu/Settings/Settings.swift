//
//  SettingsView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 10/05/2023.
//

import SwiftUI
import AlertToast

struct Settings: View {
    @Binding var open_tab: Bool
    @State private var ical_loading: Bool = false
    @State var save_ical_res: iCalResult = .success ( "" )
    @State private var ical_success: Bool = false
    let proxy: ScrollViewProxy

    var body: some View {
        NavigationStack {
            List {
                OrdoOptions ( settings_open: self.$open_tab, proxy: proxy )
                DeviceCalendar ( ical_success: self.$ical_success, ical_loading: self.$ical_loading, save_ical_res: self.$save_ical_res )
                Mail ( settings_open: self.$open_tab )
                
                Link ( "Privacy Policy", destination: URL ( string: "https://matthewfrankland.co.uk/ordo-1962/support/privacy.html" )! )
            }
            .navigationTitle ( "Settings" )
            .toast ( isPresenting: self.$ical_loading ) {
                AlertToast ( type: .loading )
            }
            .toast ( isPresenting: self.$ical_success ) {
                switch ( self.save_ical_res ) {
                case .success ( let res ):
                    return AlertToast ( type: .complete ( .green ), title: res )
                case .failure ( let res ):
                    return AlertToast ( type: .error ( .red ), title: res )
                }
            }
        }
    }
}
