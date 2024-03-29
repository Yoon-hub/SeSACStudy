//
//  UIViewController+Extension.swift
//  SeSAC2Week7Diary
//
//  Created by 최윤제 on 2022/08/18.
//

import UIKit
import SeSAC2UIFramework

extension UIViewController {
    
    func transitionViewController<T: UIViewController>(storyborad: String,viewController vc: T) {
        let sb = UIStoryboard(name: storyborad, bundle: nil)
        guard let controller = sb.instantiateViewController(withIdentifier: String(describing: vc)) as? T else { return }
        
        self.present(controller, animated: true)
    }
    
}
