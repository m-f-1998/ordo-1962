//
//  SettingsView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 10/05/2023.
//

import SwiftUI
import AlertToast

class AlertViewModel: ObservableObject {
    @Published var show = false
    @Published var alertToast = AlertToast ( type: .regular, title: "" ) {
        didSet {
            show.toggle ( )
        }
    }
}

struct Settings: View {
    private var ical: iCal
    
    @ObservedObject public var notification_alert: AlertViewModel = AlertViewModel ( )
    @ObservedObject public var ical_alert: AlertViewModel
    @State private var iCalLoading: Bool = false

    init ( current_ordo: OrdoYear ) {
        let alert = AlertViewModel ( )
        self.ical_alert = alert
        self.ical = iCal ( current_ordo: current_ordo, alert: alert )
    }

    var body: some View {
        NavigationStack {
            List {
                Section ( "Daily Notifications" ) {
                    NotificationToggle ( label: "6AM Angelus", title: "Oremus", hour: 6, id: "Angelus_Six", alert: notification_alert )
                    NotificationToggle ( label: "Noon Angelus", title: "Oremus", hour: 12, id: "Angelus_Noon", alert: notification_alert )
                    NotificationToggle ( label: "6PM Angelus", title: "Oremus", hour: 18, id: "Angelus_Eighteen", alert: notification_alert )
                }
                Section ( footer: Text ( "'Full Access' to your Phone's Calendar is Required" ) ) {
                    Button {
                        self.iCalLoading = true
                        self.ical.GenerateCalendar ( ) {
                            Task {
                                try await Task.sleep ( nanoseconds: 1_000_000_000 )
                                self.iCalLoading = false
                            }
                        }
                    } label: {
                        Text ( "Create an iCal with the \( String ( CurrentYear ( ) ) ) Ordo" )
                    }.disabled ( iCalLoading )
                }
                Section {
                    SendEmail ( )
                    MakeReview ( )
                    Link ( "Privacy Policy", destination: URL ( string: "https://matthewfrankland.co.uk/ordo-1962/support/privacy.html" )! )
                }
            }
                .toast ( isPresenting: self.$notification_alert.show ) {
                    self.notification_alert.alertToast
                }
                .toast ( isPresenting: self.$ical_alert.show ) {
                    self.ical_alert.alertToast
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
