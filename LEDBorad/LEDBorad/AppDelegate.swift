//
//  AppDelegate.swift
//  LEDBorad
//
//  Created by 최윤제 on 2022/07/06.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        sleep(1)
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // melon, youtube - 사용자 프리미엄 결제 했으면 play, 일시 정지
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // youtube - 결제 안 한 사람에게 팝업창 띄워!
        // kakaotalk - 장금화면 띄우게
        // 금융앱 화면 안보이게 막을때
    }

    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

