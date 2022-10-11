//
//  LoginViewController.swift
//  CodeNeflix
//
//  Created by 최윤제 on 2022/08/20.
//

import UIKit

class LoginViewController: BaseViewController {
    let loginView = LoginView()
        
    override func loadView() {
        self.view = loginView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(tapGestureClicked))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc
    func tapGestureClicked() {
        view.endEditing(true)
    }
    
    
    
}
