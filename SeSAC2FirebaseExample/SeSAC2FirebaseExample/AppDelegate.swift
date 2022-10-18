//
//  AppDelegate.swift
//  SeSAC2FirebaseExample
//
//  Created by 최윤제 on 2022/10/05.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // aboutRealmMigration()
        
        let config = Realm.Configuration(schemaVersion: 3) { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 { // DetailTodo, List 추가
                
            }
            if oldSchemaVersion < 2 { //EmbeddedObject 추가
                
            }
            if oldSchemaVersion < 3 { // DetailTodo에 deadline 추가
                
            }
        }
        
        Realm.Configuration.defaultConfiguration = config
        
        //swizzle하기 위해서 appDelegate에서 사용하기 위해서 타입 method 형태로 swizzleMethod를 사용합니다.
        UIViewController.swizzleMethod()
        
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        
        //원격 알림 시스템에 앱을 등록
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
    
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
        //메세지 대리자 설정
        Messaging.messaging().delegate = self
        
        //현재 등록된 토큰 가져오기
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
          }
        }
        
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

extension AppDelegate {
        
    
    func aboutRealmMigration() {
        //deleteRealmIfMigartionNeeded: 마이그레이션이 필요한 경우 기존 렘 삭제 (Realm Browser 닫고 다시 열기) << 개발할 때 편리하다
        //let config = Realm.Configuration(schemaVersion: 1, deleteRealmIfMigrationNeeded: true)
        
        let config = Realm.Configuration(schemaVersion: 6) { migration, oldSchemaVersion in
            
            //컬럼, 테이블 자체가 추가 되면 별도 코드 없이 스키마 버전만 올려주면 됩니다
            //else if를 사용하지 않는 이유는 버전 1이면 1과 2를 다 겨쳐야 하기 때문에
            if oldSchemaVersion < 1 {
             
            }
            
            if oldSchemaVersion < 2 {
                
            }
            
            if oldSchemaVersion < 3 {
                //프로퍼티명 변경 할 때 사용
                migration.renameProperty(onType: Todo.className(), from: "importance", to: "favorite")
            }
            
            // 프로퍼티 합칠 때
            // 컬럼을 생선하고 초기값을 넣어 주고 싶을 때
            if oldSchemaVersion < 4 {
                migration.enumerateObjects(ofType: Todo.className()) { oldObject, newObject in
                    guard let new = newObject else {return}
                    guard let old = oldObject else {return}
                    
                    new["userDescription"] = "안녕하세요 \(old["title"]!) 의 중요도는 \(old["favorite"]!)입니다."
                    
                }
            }
            
            if oldSchemaVersion < 5 {
                migration.enumerateObjects(ofType: Todo.className()) { oldObject, newObject in
                    guard let new = newObject else {return}
                    new["count"] = 100
                    
                }
            }
            
            // Int를 Double로 변경
            if oldSchemaVersion < 6 {
                migration.enumerateObjects(ofType: Todo.className()) { oldObject, newObject in
                    guard let new = newObject else {return}
                    guard let old = oldObject else {return}
                    
                    new["favorite"] = old["favorite"]
                }
            }
            
            
            
        }
        
        
        Realm.Configuration.defaultConfiguration = config
    }

}


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
    
    //포그라운드 알림 수신: 로컬/푸시 동일
    //카카오톡: 도이님과 채팅방, 푸시마다 설정, 화면마다 설정
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //최상단의 view를 가져오기
        guard let viewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
        
        //Setting 화면에 있다면 포그라운드 푸시 띄우지 마라!
        if viewController is SettingViewController {
            completionHandler([.badge]) // Setting 화면에서는 .badge만 받아 오게 설정
        } else {
            //포그라운드에서 볼수있도록
            completionHandler([.badge, .sound, .banner, .list])
        }
        
        
        
    }
    
    //푸시 클릭: 호두과자 장바구니 담는 화면
    //유저가 푸시를 클릭했을 때에만 수신 확인 가능
    //디바이스에 토큰 정보가 있으니 삭제 시에도 어떤식으로 처리할지 생각 해봐야한다.
    
    //특정 푸시를 클릭하면 특정 상세 화면으로 화면 전환 > 
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //사용자가 푸시를 클릭했을때 분기처리를 합니다.
        print("사용자가 푸시를 클릭했습니다.")
        
        print(response.notification.request.content.body) // 알림 메세지의 내용을 출력
        print(response.notification.request.content.userInfo) // 키랑 쌍의 내용을 가져올 수 있다.
        
        let userInfo = response.notification.request.content.userInfo
        
        if userInfo[AnyHashable("sesac")] as? String == "project" {
            print("SESAC PROJECT")
        } else {
            print("Nothing")
        }
        
        //최상단의 view를 가져오기
        guard let viewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
        
        print(viewController)
        
        // is << viewController가 ViewController의 인스턴스 라면
        
        if viewController is ViewController {
            //navigation같은 경우 스택을 쌓으면서 마지막 화면으로 도달하는 코드가 있다
            viewController.navigationController?.pushViewController(SettingViewController(), animated: true)
        } else if viewController is ProfileViewController {
            viewController.dismiss(animated: true)
        } else if viewController is SettingViewController {
            viewController.navigationController?.popViewController(animated: true)
        }
        
    }
    
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

}

