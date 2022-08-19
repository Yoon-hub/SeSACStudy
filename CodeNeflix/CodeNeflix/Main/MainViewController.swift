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
    }
        

}
