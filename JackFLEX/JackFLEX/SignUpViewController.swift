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
    
    @IBOutlet weak var errLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        designTextField(textView: emailTextField, name: "이메일 주소 또는 전화번호")
        designTextField(textView: passwdTextField, name: "비밀번호", isSecure: true)
        designTextField(textView: locationTextField, name: "위치")
        designTextField(textView: nicknameTextField, name: "닉네임")
        designTextField(textView: codeTextField, name: "추천 코드 입력")
        
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
        if emailTextField.text == "" || passwdTextField.text == ""{
            errLabel.text = "이메일 혹은 비밀번호는 필수로 입력하셔야 합니다."
        } else if passwdTextField.text!.count < 6{
            errLabel.text = "비밀번호는 6자 이상 입력하셔야 합니다."
        } else if Int(codeTextField.text!) ?? nil == nil{
            errLabel.text = "추천코드는 숫자로만 입력하셔야 합니다."
        } else{
            errLabel.textColor = .blue
            errLabel.text = "회원가입에 성공 하셨습니다람쥐"
        }
        
        
    }
    
    func designTextField( textView: UITextField, name: String, isSecure: Bool = false){
        textView.attributedPlaceholder = NSAttributedString(string: name, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        textView.textAlignment = .center
        textView.textColor = .white
        textView.keyboardType = .emailAddress
        textView.isSecureTextEntry = isSecure
        textView.borderStyle = .roundedRect
        textView.backgroundColor = .darkGray
    }
    
}
