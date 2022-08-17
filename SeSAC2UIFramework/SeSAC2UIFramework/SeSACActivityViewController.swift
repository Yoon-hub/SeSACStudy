//
//  SeSACActivityViewController.swift
//  SeSAC2UIFramework
//
//  Created by 최윤제 on 2022/08/16.
//

import UIKit

extension UIViewController {
    public func sesacShowActivityViewController(shareImage: UIImage, shareURL: String, shareText: String) {
        
        let viewController = UIActivityViewController(activityItems: [shareImage, shareURL, shareText], applicationActivities: nil)
        viewController.excludedActivityTypes = [.mail] // 제외하고 보여준다
        self.present(viewController, animated: true)
    }
}
