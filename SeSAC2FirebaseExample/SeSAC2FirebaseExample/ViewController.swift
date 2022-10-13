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
        
//        Analytics.logEvent("rejack", parameters: [
//            "name": "고래밥",
//            "full_text": "안녕하세요",
//        ])
//
//        Analytics.setDefaultEventParameters([
//            "level_name": "Caverns01",
//            "level_difficulty": 4
//        ])
    }
    
    /*
     옵트인 - 선 동의 후사용 << Apple은 이거 사용
     옵트아웃 - 선 사용 후배제
     
     ATTFramework
     맞춤형 광고 - trackingUsageDescription
     
     ex) 광고를 유저가 얼마나
     
     Firebase Crashlytics
     - 오류 기록 : 비정상 종료 통계 자동 집계 및 우선 순위 설정
     
     Dubug vs Release
     Release : 출시 시에
     

     
     */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ViewContoller viewWillApear")
    }
    
    @IBAction func profileButtonClicked(_ sender: UIButton) {
        present(ProfileViewController(), animated: true)
        
    }
    
    @IBAction func settingButtonClicked(_ sender: UIButton) {
        navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
    @IBAction func crashClicked(_ sender: UIButton) {
        
    }
    
}

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ProfileVIewCOntroller viewWillApear")
    }
   
}


class SettingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("SettingViewContoller viewWillApear")
    }
    
}

extension UIViewController {
    
    var topViewController: UIViewController? {
        return self.topViewController(currentViewController: self)
    }
    
    //최상위 뷰컨트롤러를 판단해주는 메서드
    func topViewController(currentViewController: UIViewController) -> UIViewController {
        
        //tabbar랑 타입 캐스팅이 되는지
        if let tabBarController = currentViewController as? UITabBarController, let selectedViewController = tabBarController.selectedViewController {
            
            return self.topViewController(currentViewController: selectedViewController)
            
        } else if let navigationController = currentViewController as? UINavigationController, let visibleViewController = navigationController.visibleViewController {
            
            return self.topViewController(currentViewController: visibleViewController)
            
        } else if let presentedViewController = currentViewController.presentedViewController {
            
            return self.topViewController(currentViewController: presentedViewController)
            
        } else {
            return currentViewController
        }
        
    }
    
    
}
    

extension UIViewController {
    
    //static or class 사용
    //class 오버라이딩 하기 위해서
    class func swizzleMethod() {
        
        let origin = #selector(viewWillAppear)
        let change = #selector(changeViewWillAppear)
        
        // origin 이 진짜 존재 하는지 확인 하는 코드
        guard let originMethod = class_getInstanceMethod(UIViewController.self, origin), let changeMethod = class_getInstanceMethod(UIViewController.self, change) else {
            print("함수를 찾을 수 없거나 오류 발생")
            return
        }
        
        // origin 과 change를 swizzle
        method_exchangeImplementations(originMethod, changeMethod)
            
    }
    
    @objc func changeViewWillAppear() {
        print("Change VIewWillAppear SUCCED")
    }
}
