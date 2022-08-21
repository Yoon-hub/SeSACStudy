//
//  MainViewController.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/21.
//

import UIKit

import Kingfisher

class MainViewController: UIViewController {
    
    let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.changeButton.addTarget(self, action: #selector(changeButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func changeButtonClicked() {
        let vc = ChangeViewController()
        vc.completionHandler = {
            self.mainView.backgroundImageView.kf.setImage(with: URL(string: vc.selected))
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
