//
//  MainView.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/21.
//

import UIKit
import SnapKit

class MainView: BaseView {
    
    let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bg")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let changeButton: UIButton = {
       let view = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 50)
        view.setImage(UIImage(systemName: "arrow.clockwise", withConfiguration: config), for: .normal)
        view.tintColor = .white
        return view 
    }()
    
    let titleTextField: UITextField = {
       let view = UITextField()
        view.placeholder = "제목을 입력해주세요"
        view.backgroundColor = .lightGray
        return view
    }()
    
    let titleTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let dateTextField: UITextField = {
        let view = UITextField()
         view.placeholder = "날짜를 입력 해주세여 ex) 20220504"
         view.backgroundColor = .lightGray
         return view
     }()
    
    override func configure() {
        [backgroundImageView, changeButton, titleTextField, titleTextView, dateTextField].forEach { self.addSubview($0) }
    }
    
    override func setContraints() {
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(50)
        }
        backgroundImageView.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(-30)
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.7)
            make.height.equalTo(self).multipliedBy(0.3)
            }
        
        changeButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-30)
            
        }
        
        titleTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.width.equalTo(140)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextView.snp.bottom).offset(20)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(50)
        }
        
    }
    
    
}
