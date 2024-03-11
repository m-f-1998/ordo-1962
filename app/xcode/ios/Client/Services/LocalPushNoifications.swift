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
        center.getNotificationSettings { prev in
            let notDetermined = prev.authorizationStatus == .notDetermined
            center.requestAuthorization ( options: [ .alert, .badge, .sound ], completionHandler: { ( granted, error ) in
                if error != nil {
                    DispatchQueue.main.async {
                        self.status.alertToast = AlertToast ( type: .error ( .red ), title: "An Error Occured" )
                        print ( error?.localizedDescription ?? "An Unkown Error" )
                    }
                    action ( false )
                } else if granted {
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
                            DispatchQueue.main.async {
                                self.status.alertToast = AlertToast ( type: .complete ( .green ), title: "Notification Set" )
                            }
                            action ( true )
                        }
                    }
                } else {
                    if !notDetermined {
                        if let settings = URL ( string: UIApplication.openSettingsURLString ), UIApplication.shared.canOpenURL ( settings ) {
                            DispatchQueue.main.async {
                                UIApplication.shared.open ( settings )
                            }
                        }
                    }
                    action ( false )
                }
            } )
        }
    }
}
