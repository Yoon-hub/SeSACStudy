//
//  ViewController.swift
//  SeSAC2Week7Diary
//
//  Created by 최윤제 on 2022/08/16.
//  접근 제어 안할 시 internal 로 설정된다. 

import UIKit
import SeSAC2UIFramework
import SnapKit

extension Notification.Name {
    static let saveButton = NSNotification.Name("saveButtonNotification")
}

class ViewController: UIViewController {

    let nameButton: UIButton = {
        let view = UIButton()
        view.setTitle("닉네임", for: .normal)
        view.backgroundColor = .blue
        view.tintColor = .black
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        nameButton.addTarget(self, action: #selector(nameButtonClicked) , for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveButtonNotificationObserver(notification:)), name: .saveButton, object: nil)
        

    }
    @objc
    func saveButtonNotificationObserver(notification: NSNotification) {
        if let name = notification.userInfo?["name"] as? String {
            self.nameButton.setTitle(name, for: .normal)
        } else {
            
        }
    }
    
    @objc
    func nameButtonClicked() {
        
        NotificationCenter.default.post(name: NSNotification.Name("test"), object: nil, userInfo: ["name": "\(Int.random(in: 0...100))"])
        
        let vc = ProfileViewController()
        
        vc.saveButtonActionHandler = { result in
            self.nameButton.setTitle(result, for: .normal)
        }


        
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
    
    func configure() {
        view.addSubview(nameButton)
        
        nameButton.snp.makeConstraints { make in
            make.height.width.equalTo(200)
            make.center.equalTo(view)
        }
    }

}

