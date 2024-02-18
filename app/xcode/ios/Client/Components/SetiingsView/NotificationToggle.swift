//
//  NotificationToggle.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 28/01/2024.
//

import SwiftUI
import AlertToast

struct NotificationToggle: View {
    public var label: String
    public var title: String
    public var hour: Int
    public var minute: Int
    public var id: String

    private var notifications: LocalPushNoifications

    init ( label: String, title: String, hour: Int, minute: Int = 0, id: String, alert: AlertViewModel ) {
        self.label = label
        self.title = title
        self.hour = hour
        self.minute = minute
        self.id = id
        self.notifications = LocalPushNoifications ( status: alert )
    }

    @State private var toggled = false

    var body: some View {
        Toggle ( self.label, isOn: $toggled )
        .onChange ( of: self.toggled ) {
            if toggled {
                self.notifications.RequestNotification ( title: self.title, body: self.label, hour: self.hour, minute: self.minute, id: self.id ) { res in
                    self.toggled = res
                }
            } else {
                UNUserNotificationCenter.current ( ).removePendingNotificationRequests ( withIdentifiers: [ self.id ] )
            }
        }
    }
}
