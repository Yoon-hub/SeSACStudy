//
//  AppDelegate.swift
//  SeSAC2LectureNetWorkBasic
//
//  Created by 최윤제 on 2022/07/27.
//

import UIKit

    @main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //2. 노티 제거
        UNUserNotificationCenter.current().removeAllDeliveredNotifications() // 사용자에게 이미 도착한 노티만 제거
        //UNUserNotificationCenter.current().removeAllPendingNotificationRequests() // 사용자가 받을 예정인 노티도 제거
        UNUserNotificationCenter.current().delegate = self // Delegate
        
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([ .list, .banner, .badge, .sound]) // iOS 14 list, banner <-> alert
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

