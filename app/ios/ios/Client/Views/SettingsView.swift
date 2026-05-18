//
//  SettingsView.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 10/05/2023.
//

import SwiftUI
import AlertToast

@Observable
class AlertViewModel {
    var show = false
    var alertToast = AlertToast ( type: .regular, title: "" ) {
        didSet {
            show.toggle ( )
        }
    }
}

struct Settings: View {
    @State private var ical: iCal
    
    @State var notification_alert: AlertViewModel = AlertViewModel ( )
    @State var ical_alert: AlertViewModel
    @State private var iCalLoading: Bool = false

    init ( current_ordo: OrdoYear ) {
        let alert = AlertViewModel ( )
        _ical_alert = State ( initialValue: alert )
        _ical = State ( initialValue: iCal ( current_ordo: current_ordo, alert: alert ) )
    }

    var body: some View {
        NavigationStack {
            List {
                Section ( "Daily Notifications" ) {
                    FixedTimeNotification ( label: "Oremus", title: "6AM Angelus", hour: 6, id: "Angelus_Six", alert: notification_alert )
                    FixedTimeNotification ( label: "Oremus", title: "Noon Angelus", hour: 12, id: "Angelus_Noon", alert: notification_alert )
                    FixedTimeNotification ( label: "Oremus", title: "6PM Angelus", hour: 18, id: "Angelus_Eighteen", alert: notification_alert )
                    FastingNotification ( title: "Fasting Reminder", id: "Fasting_Notification", alert: notification_alert )
                }
                Section ( footer: Text ( "'Full Access' to your Phone's Calendar is Required" ) ) {
                    Button {
                        self.iCalLoading = true
                        self.ical.GenerateCalendar ( ) {
                            Task {
                                try? await Task.sleep ( for: .seconds ( 1 ) )
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
                    Link ( "Privacy Policy", destination: URL ( string: "https://m-f-1998.github.io/ordo-1962/" ) ?? URL ( string: "https://github.com/m-f-1998/ordo-1962" )! )
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
                .tint ( .primary )
        }
    }
}
