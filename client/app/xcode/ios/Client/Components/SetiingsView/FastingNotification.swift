//
//  FastingNotification.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 03/09/2024.
//

import SwiftUI
import AlertToast
import UserNotifications
import BackgroundTasks

struct FastingNotification: View {
    @EnvironmentObject var activeData: ActiveData
    @State private var toggled = false

    public var title: String
    public var id: String

    private var alert: AlertViewModel

    init ( title: String, id: String, alert: AlertViewModel ) {
        self.title = title
        self.id = id
        self.alert = alert
    }
    
    private func CheckNotificationSettings ( result: @escaping ( Bool ) -> Void ) {
        let center = UNUserNotificationCenter.current ( )
        center.getNotificationSettings { prev in
            let notDetermined = prev.authorizationStatus == .notDetermined
            center.requestAuthorization ( options: [ .alert, .badge, .sound ], completionHandler: { ( granted, error ) in
                if error != nil {
                    DispatchQueue.main.async {
                        self.alert.alertToast = AlertToast ( type: .error ( .red ), title: "An Error Occured" )
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
    
    private func generateBody ( ) -> String {
        guard let current_day = self.activeData.GetYear ( )?.getDay ( month: CurrentMonth ( ), day: CurrentDay ( ) ) else {
            return ""
        }
        
        return current_day.fasting.joined ( separator: ", " )
    }
    
    private func generateTitle ( ) -> String {
       return self.title
    }
    
    private func scheduleBackgroundTask ( ) {
        #if !targetEnvironment(simulator)
            let request = BGProcessingTaskRequest ( identifier: "com.mfrankland.ordo-62.fasting" )
            let hour = Calendar.current.component ( .hour, from: Date ( ) )
            let minute = Calendar.current.component ( .minute, from: Date( ) )
            
            request.earliestBeginDate = Calendar.current.date ( bySettingHour: hour, minute: minute + 1, second: 0, of: Date ( ).addingTimeInterval ( 86400 ) )
//            request.earliestBeginDate = Calendar.current.date ( bySettingHour: 6, minute: 0, second: 0, of: Date ( ).addingTimeInterval ( 86400 ) )


            request.requiresNetworkConnectivity = false
            request.requiresExternalPower = false

            do {
                try BGTaskScheduler.shared.submit ( request )
            } catch {
                print ( "Could not schedule background task: \(error)" )
                DispatchQueue.main.async {
                    self.alert.alertToast = AlertToast ( type: .error ( .red ), title: "An Error Occured" )
                    self.toggled = false
                }
            }
        #else
            DispatchQueue.main.async {
                self.alert.alertToast = AlertToast ( type: .error ( .red ), title: "Notification can not be set on a Simulator" )
                self.toggled = false
            }
        #endif
    }

    private func stopBackgroundTask ( ) {
        UNUserNotificationCenter.current ( ).removePendingNotificationRequests ( withIdentifiers: [ self.id ] )
        BGTaskScheduler.shared.cancel ( taskRequestWithIdentifier: "com.mfrankland.ordo-62.fasting" )
    }

    private func handleBackgroundTask ( task: BGProcessingTask ) {
        showNotification ( )
        
        if !toggled {
            scheduleBackgroundTask ( )
        }

        task.expirationHandler = {
            task.setTaskCompleted ( success: false )
        }

        task.setTaskCompleted ( success: true )
        
        DispatchQueue.main.async {
            self.alert.alertToast = AlertToast ( type: .error ( .green ), title: "Notification Scheduled" )
            self.toggled = true
        }
    }

    private func showNotification ( ) {
        let content = UNMutableNotificationContent ( )
        content.title = generateTitle ( )
        content.body = generateBody()
        content.sound = .default

        let request = UNNotificationRequest ( identifier: self.id, content: content, trigger: nil )

        UNUserNotificationCenter.current ( ).add ( request ) { error in
            if let error = error {
                print ( "Error scheduling notification: \(error)" )
                DispatchQueue.main.async {
                    self.alert.alertToast = AlertToast ( type: .error ( .red ), title: "An Error Occured" )
                    self.toggled = false
                }
            }
        }
    }

    var body: some View {
        Toggle ( "Fasting Notification", isOn: $toggled ).onChange ( of: self.toggled ) {
            CheckNotificationSettings ( ) { res in
                if res {
                    if toggled {
                        BGTaskScheduler.shared.register ( forTaskWithIdentifier: "com.mfrankland.ordo-62.fasting", using: nil ) { task in
                            scheduleBackgroundTask ( )
                        }
                    } else {
                        stopBackgroundTask ( )
                    }
                }
            }
        }
    }
}
