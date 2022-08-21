//
//  MainViewController.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/21.
//

import UIKit

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
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
