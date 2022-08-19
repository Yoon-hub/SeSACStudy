//
//  SeSACButton.swift
//  SeSAC2UIFramework
//
//  Created by 최윤제 on 2022/08/17.
//

import Foundation
import UIKit

extension UIButton {
    
    public func setButton(systemName: String) {
        
        let config = UIImage.SymbolConfiguration(pointSize: 50)
        self.setImage(UIImage(systemName: systemName , withConfiguration: config), for: .normal)
        self.tintColor = .white
        
    }
}
