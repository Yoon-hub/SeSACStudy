//
//  ViewController.swift
//  SeSAC2LectureNetWorkBasic
//
//  Created by 최윤제 on 2022/07/27.
//

import UIKit

class ViewController: UIViewController{
    
    var navigationTitleString: String {
        get{
            return "대장님의 다마고치"
        }
        set{
            title = newValue
        }
    }
    
    var backgroundColor: UIColor {
        get{
            return .blue
        }
    }

    func configureView() {
        
        navigationTitleString = "고래밥님의 다마고치"
        
        
        view.backgroundColor = backgroundColor
        title = navigationTitleString
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        UserDefaultsHelper.standard.nickname = "고래밥"

    }
    
 
    func configureLable() {
        
    }


}

