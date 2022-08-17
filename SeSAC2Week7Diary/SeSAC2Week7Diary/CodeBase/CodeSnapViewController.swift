//
//  CodeSnapViewController.swift
//  SeSAC2Week7Diary
//
//  Created by 최윤제 on 2022/08/17.
//

import UIKit
import SnapKit

class CodeSnapViewController: UIViewController {

    let photoImageView = UIImageView()
    let titletextField = UITextField()
    let dateTextField = UITextField()
    let contentTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confingUI()
    }
    
    func confingUI() {
        
        //for - in vs foreach
        [photoImageView, titletextField, dateTextField, contentTextView].forEach {
            view.addSubview($0)
        }
        photoImageView.backgroundColor = .lightGray
        photoImageView.contentMode = .scaleAspectFill
        
        titletextField.borderStyle = .none
        titletextField.layer.borderColor = UIColor.black.cgColor
        titletextField.layer.borderWidth = 1
        titletextField.placeholder = "제목을 입력해주세요"
        titletextField.textAlignment = .center
        titletextField.font = .boldSystemFont(ofSize: 15)
        
    }

}
