//
//  FastingNotification.swift
//  ordo-1962
//

import SwiftUI
import AlertToast
import UserNotifications
import BackgroundTasks

class FastingNotificationManager {
    static let shared = FastingNotificationManager ( )
    
    func register ( ) {
        #if !targetEnvironment(simulator)
        BGTaskScheduler.shared.register ( forTaskWithIdentifier: "com.mfrankland.ordo1962.fasting", using: nil ) { task in
            guard let processingTask = task as? BGProcessingTask else { return }
            self.handleBackgroundTask ( task: processingTask )
        }
        #endif
    }
    
    private func handleBackgroundTask ( task: BGProcessingTask ) {
        scheduleNextTask ( )
        showNotification ( )
        
        task.expirationHandler = {
            task.setTaskCompleted ( success: false )
        }
        task.setTaskCompleted ( success: true )
    }
    
    func scheduleNextTask ( ) {
        #if !targetEnvironment(simulator)
        let request = BGProcessingTaskRequest ( identifier: "com.mfrankland.ordo1962.fasting" )
        let hour = Calendar.current.component ( .hour, from: Date ( ) )
        let minute = Calendar.current.component ( .minute, from: Date( ) )
        
        request.earliestBeginDate = Calendar.current.date ( bySettingHour: hour, minute: minute + 1, second: 0, of: Date ( ).addingTimeInterval ( 86400 ) )

        request.requiresNetworkConnectivity = false
        request.requiresExternalPower = false

        do {
            try BGTaskScheduler.shared.submit ( request )
        } catch {
            print ( "Could not schedule background task: \(error)" )
        }
        #endif
    }
    
    func cancelTask ( ) {
        #if !targetEnvironment(simulator)
        BGTaskScheduler.shared.cancel ( taskRequestWithIdentifier: "com.mfrankland.ordo1962.fasting" )
        #endif
    }
    
    private func showNotification ( ) {
        guard UserDefaults.standard.bool ( forKey: "fasting_notification_enabled" ) else { return }
        
        let cache = Cache ( )
        guard let ordo = try? cache.GetOrdo ( predicate: #Predicate<OrdoYear> { _ in true } ),
              !ordo.isEmpty else { return }
        
        let todayMonth = Calendar.current.shortMonthSymbols [ Calendar.current.component ( .month, from: .now ) - 1 ]
        let todayDay = Calendar.current.component ( .day, from: .now )
        let day = ordo [ 0 ].getDay ( month: todayMonth, day: todayDay )
        guard !day.fasting.isEmpty else { return }
        
        let content = UNMutableNotificationContent ( )
        content.title = "Fasting Reminder"
        content.body = day.fasting.joined ( separator: ", " )
        content.sound = .default

        let request = UNNotificationRequest ( identifier: "Fasting_Notification", content: content, trigger: nil )
        UNUserNotificationCenter.current ( ).add ( request ) { error in
            if let error = error {
                print ( "Error scheduling notification: \(error)" )
            }
        }
    }
}

struct FastingNotification: View {
    @Environment(ActiveData.self) var activeData
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
                        self.alert.alertToast = AlertToast ( type: .error ( .red ), title: "An Error Occurred" )
                    }
                    result ( false )
                } else if granted {
                    result ( true )
                } else {
                    if !notDetermined {
                        if let settings = URL ( string: UIApplication.openNotificationSettingsURLString ), UIApplication.shared.canOpenURL ( settings ) {
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

    var body: some View {
        Toggle ( "Fasting Notification", isOn: $toggled )
        .onAppear {
            self.toggled = UserDefaults.standard.bool ( forKey: "fasting_notification_enabled" )
        }
        .onChange ( of: self.toggled ) { old, new in
            UserDefaults.standard.set ( new, forKey: "fasting_notification_enabled" )
            CheckNotificationSettings ( ) { res in
                if res {
                    if new {
                        FastingNotificationManager.shared.scheduleNextTask ( )
                        DispatchQueue.main.async {
                            self.alert.alertToast = AlertToast ( type: .complete ( .green ), title: "Notification Scheduled" )
                        }
                    } else {
                        FastingNotificationManager.shared.cancelTask ( )
                        UNUserNotificationCenter.current ( ).removePendingNotificationRequests ( withIdentifiers: [ self.id ] )
                    }
                } else {
                    self.toggled = false
                }
            }
        }
    }
}
