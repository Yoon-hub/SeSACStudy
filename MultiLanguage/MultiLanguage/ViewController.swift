//
//  ViewController.swift
//  MultiLanguage
//
//  Created by 최윤제 on 2022/10/06.
//

import UIKit

import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //nameLabel.text = NSLocalizedString("test_name", comment: "")
        nameLabel.text = "test_name".localized
        //ageLabel.text = NSLocalizedString("test_age", comment: "")
        ageLabel.text = "test_age".localized
        
//        for i in 1...50 {
//            let task = Memo(content: "\(i)번째")
//
//            try! localRealm.write {
//              localRealm.add(task)
//            }
//
//        }
        print("Realm is located at:", localRealm.configuration.fileURL!) // Realm파일 위치 출력
        
       // print(RealmManager.shared.getAllMemo())
       
        
    }
    

    
}


extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
