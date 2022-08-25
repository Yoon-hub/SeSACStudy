//
//  BaseViewController.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    func showAlert(_ title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
   
    
}
