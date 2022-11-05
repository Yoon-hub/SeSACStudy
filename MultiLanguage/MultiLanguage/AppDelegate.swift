//
//  AppDelegate.swift
//  MultiLanguage
//
//  Created by 최윤제 on 2022/10/06.
//

import UIKit

import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let defaultRealm = Realm.Configuration.defaultConfiguration.fileURL!
        // Container for newly created App Group Identifier
        let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.sesac.MultiLanguage")
        // Shared path of realm config
        let realmURL = container?.appendingPathComponent("default.realm")
        // Config init
        var config: Realm.Configuration!

        // Checking the old realm config is exist
        if FileManager.default.fileExists(atPath: defaultRealm.path) {
            do {
              // Replace old config with the new one
                _ = try FileManager.default.replaceItemAt(realmURL!, withItemAt: defaultRealm)

               config = Realm.Configuration(fileURL: realmURL, schemaVersion: 1)
            } catch {
               print("Error info: \(error)")
            }
        } else {
             config = Realm.Configuration(fileURL: realmURL, schemaVersion: 1)
        }

        // Lastly init realm config to default config
        Realm.Configuration.defaultConfiguration = config
        
        return true
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

