//
//  ViewController.swift
//  SeSAC2FirebaseExample
//
//  Created by 최윤제 on 2022/10/05.
//

import UIKit
import FirebaseAnalytics

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Analytics.logEvent("rejack", parameters: [
            "name": "고래밥",
            "full_text": "안녕하세요",
        ])
        
        Analytics.setDefaultEventParameters([
            "level_name": "Caverns01",
            "level_difficulty": 4
        ])
    }
    
    /*
     옵트인 - 선동의 후사용 << Apple은 이거 사용
     옵트아웃 - 선사용 후배제
     
     ATTFramework
     맞춤형 광고 - trackingUsageDescription
     
     ex) 광고를 유저가 얼마나
     
     Firebase Crashlytics
     - 오류 기록 : 비정상 종료 통계 자동 집계 및 우선 순위 설정
     
     Dubug vs Release
     Release : 출시 시에
     
     */
    
}
     

