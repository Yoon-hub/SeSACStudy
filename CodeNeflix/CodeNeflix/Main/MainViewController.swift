//
//  MainViewController.swift
//  CodeNeflix
//
//  Created by 최윤제 on 2022/08/19.
//

import UIKit

class MainViewController: BaseViewController {
    
    let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
        mainView.playButton.addTarget(self, action: #selector(playButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func playButtonClicked() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
        
    }
        

}
