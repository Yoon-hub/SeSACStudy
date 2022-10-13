//
//  ViewController.swift
//  MultiLanguage
//
//  Created by 최윤제 on 2022/10/06.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //nameLabel.text = NSLocalizedString("test_name", comment: "")
        nameLabel.text = "test_name".localized
        //ageLabel.text = NSLocalizedString("test_age", comment: "")
        ageLabel.text = "test_age".localized
        
    }
}


extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
