//
//  LocalPushNoifications.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 28/01/2024.
//

import SwiftUI
import AlertToast

class LocalPushNoifications {
    @ObservedObject public var status: AlertViewModel
    
    init ( status: AlertViewModel ) {
        self.status = status
    }

    func RequestNotification ( title: String, body: String, hour: Int, minute: Int = 0, id: String, action: @escaping ( ( Bool ) -> Void ) ) {
        let center = UNUserNotificationCenter.current ( )
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                center.requestAuthorization ( options: [ .alert, .badge, .sound ] ) { success, error in
                    if success {
                        let notificationContent = UNMutableNotificationContent ( )
                        notificationContent.title = title
                        notificationContent.body = body
                        notificationContent.sound = .default
                                        
                        let datComp = DateComponents ( hour: hour, minute: minute )
                        let trigger = UNCalendarNotificationTrigger ( dateMatching: datComp, repeats: true )
                        let request = UNNotificationRequest ( identifier: id, content: notificationContent, trigger: trigger )
                        center.add ( request ) { ( error : Error? ) in
                            if let theError = error {
                                DispatchQueue.main.async {
                                    self.status.alertToast = AlertToast ( type: .error ( .red ), title: "An Error Occured" )
                                    print ( theError.localizedDescription )
                                }
                                action ( false )
                            } else {
                                action ( true )
                            }
                        }
                    } else if let error = error {
                        DispatchQueue.main.async {
                            self.status.alertToast = AlertToast ( type: .error ( .red ), title: "An Error Occured" )
                            print ( error.localizedDescription )
                        }
                        action ( false )
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.status.alertToast = AlertToast ( type: .error ( .red ), title: "Push Notification Permissions Denied" )
                }
                action ( false )
            }
        }
    }
}
