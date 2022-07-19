//
//  UIViewController+extension.swift
//  SettingProject
//
//  Created by 최윤제 on 2022/07/19.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setBackgroundColor(){
        view.backgroundColor = .orange
    }
    func showAlert(alertTitle: String, alertMessage: String){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        
        present(alert,animated: true, completion: nil)
    }
}
