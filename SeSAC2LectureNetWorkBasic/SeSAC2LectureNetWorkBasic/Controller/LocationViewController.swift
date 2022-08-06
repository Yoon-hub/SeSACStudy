//
//  LocationViewController.swift
//  SeSAC2LectureNetWorkBasic
//
//  Created by 최윤제 on 2022/07/29.
//

import UIKit

//badge << 아이콘옆에 빨간색
class LocationViewController: UIViewController {
    
    
    // Notification 1.
    @IBOutlet weak var imageView: UIImageView!
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
            super.viewDidLoad()
    
    }
    
    // Notification 2. 권한 요청
    func requestAuthorization(){
        
        let authorizationOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        notificationCenter.requestAuthorization(options: authorizationOptions) { success, error in
            
            if success {
                self.sendNotification()
            } else {
                print("error!!")
            }
            
        }
        
    }
    
    // Notification 3. 권한 허용한 사용자에게 알림 요청(언제? 어떤 건텐츠?)
    // iOS 시스템에서 알림을 담당 > 알림 등록
    
    
    /*
     
     - 권한 허용 해야한 알림이 온다.
     - 권한 허용 문구 시스템적으로 최초 한번만 뜬다
     - 허용 안 된 경우 애플 설정으로 직접 유도하는 코드를 구성 해야 한다.
     
     - 기본적으로 알림은 포그라운드에서 수신되지 않는다.
     - 로컬 알림에서는 60초 이상 반복 가능 / 갯수 제한 64개
     
     1. 뱃지 제거? >> 앱이 액티브 되었을때
     2. 노티 제거? 
     3. 포그라운드 수신 >> 딜리게이트 메서드로 해결
     
     +a
     - 노티는 앱 실행이 기본인데, 특정 노티를 클릭하 떄 특정 화면으로 가고 싶다면?
     - 포그라운드 수신, 특정 화면에서는 안받고 특정 조건에 대해서만 포그라운드 수신을 하고 싶다면
     */
    
    func sendNotification(){
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "오늘은 어떤 빵을 먹을까요?"
        notificationContent.body = "따끈따끈 소보루"
        notificationContent.badge = 1
        
        // 언제 보낼 것인가> 1. 시간 간격 2. 캘린더 3. 위치에 따라 설정 가능
        // 시간 간격을 60초 이상 실행해야 반복 가능
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        var dateComponents = DateComponents()
        dateComponents.minute = 15
        
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        //알림 요청
        //identifier:
        //만약 알림 관리 할 필요 X -> 알림 클릭하면 앱을 켜주는 정도
        //만약 알림 관리 할 필요 O -> 고유 이름, 규칙 등
        
        let request = UNNotificationRequest(identifier: "\(Date())", content: notificationContent, trigger: trigger)
        
        notificationCenter.add(request)
    }
    
    @IBAction func noticationButtonClicked(_ sender: UIButton) {
        requestAuthorization()
    }
    
    @IBAction func donloadImage(_ sender: UIButton) {
        let url = "https://apod.nasa.gov/apod/image/2208/M13_final2_sinfirma.jpg"
        print("1", Thread.isMainThread)
        
        DispatchQueue.global().async { //동시 여러 작업 가능하게 해줘! 응애
            print("2", Thread.isMainThread)
            let data = try! Data(contentsOf: URL(string: url)!)
            let image = UIImage(data: data)
            
            DispatchQueue.main.async { // 화면 전환 하는 작업을 띠워준다
                print("3", Thread.isMainThread)
                self.imageView.image = image
            }
            
        }

    }
    
}
