//
//  ReusableProtocol.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/22.
//

import UIKit

protocol Reusable {
    static var reusable: String { get }

}

extension UICollectionViewCell: Reusable {
    
   static var reusable: String {
         return String(describing: self)
    }
    
    
}
