//
//  UITextField+Extension.swift
//  SettingProject
//
//  Created by 최윤제 on 2022/07/19.
//

import UIKit

extension UITextField{
    
    func borderColor(){
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.borderStyle = .none
    }
}
