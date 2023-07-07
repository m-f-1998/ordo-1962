//
//  AppDelegate.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 23/04/2023.
//

import UIKit
import FirebaseCore
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate {
    func application ( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [ UIApplication.LaunchOptionsKey : Any ]? = nil ) -> Bool {        
        // FCM Config
        FirebaseConfiguration.shared.setLoggerLevel ( .min )
        FirebaseApp.configure ( )
        Messaging.messaging ( ).delegate = self
        
        UNUserNotificationCenter.current().delegate = self

        UNUserNotificationCenter.current ( ).requestAuthorization (
          options: [ .alert, .badge, .sound ],
          completionHandler: { _, _ in }
        )

        // Register For Notifications
        application.registerForRemoteNotifications ( )

        return true
    }
    
    // Tells the delegate that the app successfully registered with Apple Push Notification service (APNs).
    // iOS 3+
    func application ( _ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data ) {
        // With swizzling disabled you must set the APNs token here.
        Messaging.messaging ( ).apnsToken = deviceToken
    }
    
    // Tells the delegate when Apple Push Notification service cannot successfully complete the registration process.
    // iOS 3+
    func application ( _ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error ) {
        print ( "Unable to register for remote notifications: \(String ( describing: error ))" )
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate { // iOS 10 +
    // Asks the delegate how to handle a notification that arrived while the app was running in the foreground.
    // App must be actively running on screen.
    func userNotificationCenter ( _ center: UNUserNotificationCenter, willPresent notification: UNNotification ) async -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        Messaging.messaging ( ).appDidReceiveMessage ( userInfo )
        return [ .list, .banner, .sound ]
    }

    // Asks you to make any needed changes to the notification and notify the system when you’re done.
    // App must be in the background, and is not called until tapped.
    func userNotificationCenter ( _ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse ) async {
        let userInfo = response.notification.request.content.userInfo

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        Messaging.messaging ( ).appDidReceiveMessage ( userInfo )
    }
}

extension AppDelegate: MessagingDelegate { // FIRMessagingDelegate
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        let userInfo: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: userInfo
        )
        // This callback is fired at each app startup and whenever a new token is generated.
    }
}
