//
//  ShoppingTableViewController.swift
//  SettingProject
//
//  Created by 최윤제 on 2022/07/19.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.placeholder = "무엇을 구매하실 건가요?"
        addButton.layer.cornerRadius = 10
    }

}
    