//
//  LoginViewController.swift
//  SeSAC2Week9
//
//  Created by 최윤제 on 2022/09/01.
//

import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel.name.bind { text in
            self.nameTextField.text = text
        }

        viewModel.passwd.bind { text in
            self.passwordTextField.text = text
        }

        viewModel.email.bind { text in
            self.emailTextField.text = text
        }
        
        viewModel.isValid.bind { bool in
            self.loginButton.isEnabled = bool
            self.loginButton.backgroundColor = bool ? .red : .lightGray
        }
    }
    
    @IBAction func nameTextFieldClicked(_ sender: UITextField) {
        viewModel.name.value = nameTextField.text!
        viewModel.checkValidation()
    }
    
    @IBAction func emailTextFieldClicked(_ sender: UITextField) {
        viewModel.email.value = emailTextField.text!
        viewModel.checkValidation()
    }
    
    @IBAction func passwrodTextFeildChaged(_ sender: UITextField) {
        viewModel.passwd.value = passwordTextField.text!
        viewModel.checkValidation()
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        viewModel.signIn {
            //화면 전환 코드
        }
    }
    
}


