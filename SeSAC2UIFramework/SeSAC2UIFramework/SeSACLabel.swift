//
//  SeSACLabel.swift
//  SeSAC2UIFramework
//
//  Created by 최윤제 on 2022/08/17.
//

import Foundation
import UIKit

extension UILabel {
    public func setLable(title: String) {
        self.text = title
        self.font = .boldSystemFont(ofSize: 12)
        self.textColor = .white
        self.textAlignment = .center

    }
}
