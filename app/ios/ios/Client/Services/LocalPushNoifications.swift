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
    
    private func CheckNotificationSettings ( result: @escaping ( Bool ) -> Void ) {
        let center = UNUserNotificationCenter.current ( )
        center.getNotificationSettings { prev in
            let notDetermined = prev.authorizationStatus == .notDetermined
            center.requestAuthorization ( options: [ .alert, .badge, .sound ], completionHandler: { ( granted, error ) in
                if error != nil {
                    DispatchQueue.main.async {
                        self.status.alertToast = AlertToast ( type: .error ( .red ), title: "An Error Occured" )
                    }
                    result ( false )
                } else if granted {
                    result ( true )
                } else {
                    if !notDetermined {
                        if let settings = URL ( string: UIApplication.openSettingsURLString ), UIApplication.shared.canOpenURL ( settings ) {
                            DispatchQueue.main.async {
                                UIApplication.shared.open ( settings )
                            }
                        }
                    }
                    result ( false )
                }
            } )
        }
    }
    
    private func SetNotification ( hour: Int, minute: Int, id: String, repeats: Bool, action: @escaping ( ( Bool ) -> Void ), center: UNUserNotificationCenter, content: UNMutableNotificationContent ) {
        let datComp = DateComponents ( hour: hour, minute: minute )
        let trigger = UNCalendarNotificationTrigger ( dateMatching: datComp, repeats: repeats )
        let request = UNNotificationRequest ( identifier: id, content: content, trigger: trigger )
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
    }

    func RequestNotification ( title: Any, body: Any, hour: Int, minute: Int = 0, id: String, repeats: Bool, action: @escaping ( ( Bool ) -> Void ) ) {
        let center = UNUserNotificationCenter.current ( )
        CheckNotificationSettings ( ) { res in
            if ( res ) {
                let notificationContent = UNMutableNotificationContent ( )
                if let titleClosure = title as? ( ) -> String {
                  notificationContent.title = titleClosure ( )
                } else if let titleString = title as? String {
                  notificationContent.title = titleString
                }
                if let bodyClosure = body as? ( ) -> String {
                    notificationContent.body = bodyClosure()
                } else if let bodyString = body as? String {
                    notificationContent.body = bodyString
                }
                notificationContent.sound = .default

                self.SetNotification ( hour: hour, minute: minute, id: id, repeats: repeats, action: action, center: center, content: notificationContent )
            }
        }
    }
}
