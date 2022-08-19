//
//  ProfileViewController.swift
//  SeSAC2Week7Diary
//
//  Created by 최윤제 on 2022/08/18.
//

import UIKit

class ProfileViewController: UIViewController {
    let saveButton: UIButton = {
        let view = UIButton()
        view.setTitle("저장", for: .normal)
        view.backgroundColor = .black
        return view
    }()
    
    let nameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "이름을 입력하세요"
        view.backgroundColor = .brown
        view.textColor = .white
        return view
    }()
    
    
    //기능 구현은 안하고 선언만 해둔다
    var saveButtonActionHandler: ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [saveButton, nameTextField].forEach { view.addSubview($0)}
        
        nameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(50)
            make.top.equalTo(50)
            make.height.equalTo(50)
        }
        
        saveButton.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.center.equalTo(view)
        }
        
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveButtonNotificationObserver(notification:)), name: NSNotification.Name("test"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("test"), object: nil)
    }
    
    @objc
    func saveButtonNotificationObserver(notification: NSNotification) {
        if let name = notification.userInfo?["name"] as? String {
           print(name)
        } else {
            
        }
    }
    
    @objc
    func saveButtonClicked() {
        
        //값 전달 기능 실행 => 클로저 구문 활용
        //1. 클로저
        //saveButtonActionHandler?(nameTextField.text!)
        //2. Notification
        NotificationCenter.default.post(name: NSNotification.Name("saveButtonNotification"), object: nil, userInfo: ["name": nameTextField.text!, "value": 123])
        
        dismiss(animated: true)
        
    }
    


}
