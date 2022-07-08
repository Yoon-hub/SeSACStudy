//
//  SignUpViewController.swift
//  JackFLEX
//
//  Created by 최윤제 on 2022/07/06.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwdTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    
    @IBOutlet weak var registButton: UIButton!
    @IBOutlet weak var mySwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        designTextField(textView: emailTextField, name: "이메일 주소 또는 전화번호", isSecure: false)
        designTextField(textView: passwdTextField, name: "비밀번호", isSecure: true)
        designTextField(textView: locationTextField, name: "위치", isSecure: false)
        designTextField(textView: nicknameTextField, name: "닉네임", isSecure: false)
        designTextField(textView: codeTextField, name: "추천 코드 입력", isSecure: false)
        
        registButton.setTitle("회원가입", for: .highlighted)
        registButton.setTitleColor(.black, for: .normal)
        registButton.backgroundColor = .white
        registButton.layer.cornerRadius = 8
        
        mySwitch.setOn(true, animated: true)
        mySwitch.onTintColor = .red
        
        
        
    }
    
    @IBAction func touchGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func registButtonClicked(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    func designTextField( textView: UITextField, name: String, isSecure: Bool){
        textView.attributedPlaceholder = NSAttributedString(string: name, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        textView.textAlignment = .center
        textView.textColor = .white
        textView.keyboardType = .emailAddress
        textView.isSecureTextEntry = isSecure
        textView.borderStyle = .roundedRect
        textView.backgroundColor = .darkGray
    }
    
}
