//
//  LoginView.swift
//  CodeNeflix
//
//  Created by 최윤제 on 2022/08/20.
//
import UIKit
import SnapKit

class LoginView: BaseView {
    
    let titleLabel: UILabel = {
       let view = UILabel()
        view.text = "JACKFLIX"
        let weight = UIFont.Weight(30)
        view.font = .systemFont(ofSize: 35, weight: weight)
        view.textColor = .red
        return view
        
    }()
    
    let emailTextField: CustomTextField = {
        let view = CustomTextField()
        view.attributedPlaceholder = NSAttributedString(string: "이메일 주소 또는 전화번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        view.keyboardType = .emailAddress
        return view
    }()
    
    let passWdTextField: CustomTextField = {
        let view = CustomTextField()
        view.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        view.keyboardType = .emailAddress
        view.isSecureTextEntry = true
        return view
    }()
    
    let nickNameTextField: CustomTextField = {
        let view = CustomTextField()
        view.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        view.keyboardType = .emailAddress
        return view
    }()
    
    let locationTextField: CustomTextField = {
        let view = CustomTextField()
        view.attributedPlaceholder = NSAttributedString(string: "위치", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        view.keyboardType = .emailAddress
        return view
    }()
    
    let recommandTextField: CustomTextField = {
        let view = CustomTextField()
        view.attributedPlaceholder = NSAttributedString(string: "추천 코드 입력", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        view.keyboardType = .numberPad
        return view
    }()
    
    let registButton: UIButton = {
       let view = UIButton()
        view.backgroundColor = .white
        view.setTitle("회원가입", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        view.layer.cornerRadius = 10
        return view
    }()
    
    let moreSwitch: UISwitch = {
        let view = UISwitch()
        view.setOn(true, animated: true)
        view.onTintColor = .red
        view.backgroundColor = .gray
        view.layer.cornerRadius = view.frame.height / 2.0
        return view
    }()
    
    let moreLabel: UILabel = {
       let view = UILabel()
        view.text = "추가 정보 입력"
        view.textColor = .white
        return view
    }()
    
    override func configure() {
        [titleLabel, emailTextField, passWdTextField, nickNameTextField, locationTextField, recommandTextField, registButton, moreSwitch, moreLabel].forEach { self.addSubview($0) }
    }
    
    override func setConstaints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(80)
            make.centerX.equalTo(self)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self).offset(UIScreen.main.bounds.height / 3)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(40)
        }
        
        passWdTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(40)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(passWdTextField.snp.bottom).offset(16)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(40)
        }
        
        locationTextField.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(16)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(40)
        }
        
        recommandTextField.snp.makeConstraints { make in
            make.top.equalTo(locationTextField.snp.bottom).offset(16)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(40)
        }
        registButton.snp.makeConstraints{ make in
            make.top.equalTo(recommandTextField.snp.bottom).offset(16)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(55)
        }
        moreSwitch.snp.makeConstraints { make in
            make.top.equalTo(registButton.snp.bottom).offset(16)
            make.trailing.equalTo(self).offset(-20)
    
        }
        
        moreLabel.snp.makeConstraints { make in
            make.top.equalTo(registButton.snp.bottom).offset(16)
            make.leading.equalTo(self).offset(20)
        }
        
    }
    

    
}
