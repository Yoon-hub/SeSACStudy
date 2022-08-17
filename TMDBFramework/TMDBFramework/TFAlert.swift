//
//  TFAlert.swift
//  TMDBFramework
//
//  Created by 최윤제 on 2022/08/16.
//

import UIKit

extension UIViewController {
    
    public func makeAlert(title: String, message: String, buttontitle: String, buttonAction: @escaping (UIAlertAction) -> () ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: buttontitle, style: .default, handler: buttonAction)
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
}
