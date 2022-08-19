//
//  WriteViewController.swift
//  SeSAC2Week7Diary
//
//  Created by 최윤제 on 2022/08/19.
//

import UIKit
import SnapKit

class WriteViewController: BaseViewController {
    var mainView = WriteView()
    
    //ViewDidLoad보다 먼저 호출
    override func loadView() { //super.loadView X, RootView를 변경 해주는 작업을 여기서
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
     

    override func configure() {
        mainView.titletextField.addTarget(self, action: #selector(titleTextField(_:)), for: .editingDidEndOnExit)
    }
    
    @objc func titleTextField(_ textField: UITextField) {
        guard let text = textField.text, text.count > 0 else {
            showAlertMessage(title: "제목을 입력해주세요", button: "확인")
            return
        }
    }
    

}
