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
    @State private var locale: String = "General"
    private let locations: [ String ] = [
        "General"
    ]

    init ( current_ordo: OrdoYear ) {
        self.ical_status = iCalStatus ( current_ordo: current_ordo )
    }

    var body: some View {
        NavigationStack {
            List {
                Section ( header: Text ( "App Options" ), footer: Text ( "Coming Soon" ) ) {
                    Picker ( "Localization", selection: $locale ) {
                        ForEach ( self.locations, id: \.self ) {
                            Text ( $0 )
                        }
                    }
                }
                Button {
                    self.ical_status.loading = true
                    Task {
                        await self.ical_status.GenerateCalendar ( )
                    }
                } label: {
                    Text ( "Create an iCal with the \( String ( CurrentYear ( ) ) ) Ordo" )
                }
                Section {
                    SendEmail ( )
                    Link ( "Privacy Policy", destination: URL ( string: "https://matthewfrankland.co.uk/ordo-1962/support/privacy.html" )! )
                }
            }
                .toast ( isPresenting: self.$ical_status.loading ) {
                    return AlertToast ( type: .loading )
                }
                .toast ( isPresenting: self.$ical_status.success ) {
                    return AlertToast ( type: .complete ( .green ), title: self.ical_status.message )
                }
                .toast ( isPresenting: self.$ical_status.error ) {
                    return AlertToast ( type: .error ( .red ), title: self.ical_status.message )
                }
                .toolbar {
                    ToolbarItem ( placement: .topBarLeading ) {
                        Text ( "1962 Liturgical Ordo" )
                            .bold ( )
                    }
                }
                .navigationBarTitleDisplayMode ( .inline )
                .tint ( .blue )
        }
    }
}
