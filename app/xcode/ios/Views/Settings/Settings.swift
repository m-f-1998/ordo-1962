//
//  SettingsView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 10/05/2023.
//

import SwiftUI
import AlertToast

struct Settings: View {
    @ObservedObject private var ical_status: iCalStatus
    
    init ( current_ordo: OrdoYear ) {
        self.ical_status = iCalStatus ( current_ordo: current_ordo )
    }

    var body: some View {
        NavigationStack {
            List {
                Options ( )
                Section {
                    Button {
                        self.ical_status.loading = true
                        Task {
                            await self.ical_status.GenerateCalendar ( )
                        }
                    } label: {
                        Text ( "Create \( String ( CurrentYear ( ) ) ) Liturgical Ordo iCal" )
                    }
                } header: {
                    Text ( "Calendar" )
                }
                Section {
                    SendEmail ( )
                }
                Link ( "Privacy Policy", destination: URL ( string: "https://matthewfrankland.co.uk/ordo-1962/support/privacy.html" )! )
            }
                .navigationTitle ( "Settings" )
                .navigationBarTitleDisplayMode ( .inline )
                .toast ( isPresenting: self.$ical_status.loading ) {
                    return AlertToast ( type: .loading )
                }
                .toast ( isPresenting: self.$ical_status.success ) {
                    return AlertToast ( type: .complete ( .green ), title: self.ical_status.message )
                }
                .toast ( isPresenting: self.$ical_status.error ) {
                    return AlertToast ( type: .error ( .red ), title: self.ical_status.message )
                }
        }
    }
}
