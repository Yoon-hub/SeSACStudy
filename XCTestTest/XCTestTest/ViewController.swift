//
//  ViewController.swift
//  XCTestTest
//
//  Created by 최윤제 on 2022/11/29.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var passwdTextField: UITextField!
    @IBOutlet weak var checkTextField: UITextField!

    @IBOutlet weak var descriptionlabel: UILabel!
    
    var user = User(email: "", password: "", check: "")
    var validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        descriptionlabel.accessibilityIdentifier = "label"
        
        if validator.isValidEmail(email: user.email) && validator.isValidPassword(password: user.password) && validator.isEqualPassword(password: user.password, check: user.check) {
            print("로그인 성공!")
        } else {
            print("로그인 실패!")
        }
        
//        if isValidEmail() && isValidPassword() && isEqualPassword() {
//            print("로그인 성공!@")
//        } else {
//            print("로그인 실패!@")
//        }
    }
    

    @IBAction func loginButtonClicked(_ sender: UIButton) {
        descriptionlabel.text = "로그인 버튼을 눌렀습니다."
    }
    
    func isValidEmail() -> Bool {
        guard let email = emailTextFeild.text else { return false }
        return email.contains("@") && email.count > 8
    }
    
    func isValidPassword() -> Bool {
        guard let password = passwdTextField.text else {return false}
        return password.count >= 6 && password.count < 12
    }
    
    func isEqualPassword() -> Bool {
        guard let password = passwdTextField.text, let check = checkTextField.text else { return false}
        return password == check
    }
}


final class Validator {
    
    func isValidEmail(email: String) -> Bool {
        return email.contains("@") && email.count >= 8
    }
    
    func isValidPassword(password: String) -> Bool {
        return password.count >= 6 && password.count < 12
    }
    
    func isEqualPassword(password: String, check: String) -> Bool {
        return password == check
    }
    
}

struct User {
    let email: String
    let password: String
    let check: String
}
