//
//  SearchViewController.swift
//  Book
//
//  Created by 최윤제 on 2022/07/21.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = .init(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(backButton))
        navigationItem.leftBarButtonItem?.tintColor = .black
      
    }
    @objc func backButton(){
        self.dismiss(animated: true)
    }


}
