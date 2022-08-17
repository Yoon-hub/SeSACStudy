//
//  CodeBaseViewController.swift
//  SeSAC2Week7Diary
//
//  Created by 최윤제 on 2022/08/17.
//

import UIKit

/*
 공통
 1. 뷰객체 프로퍼티 선언. 클래스의 인스턴스를 생성
 2. 명시적으로 루트뷰에 추가
 3. 크기와 위치 및 속성 정의
   => Frame 기반 한계
   => AutoResizingMask, AutoLayout 등장!
   => NSLayoutConstraints
 */

class CodeBaseViewController: UIViewController {
    
    //1. 뷰객체 프로퍼티 선언. 클래스의 인스턴스를 생성
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        //2. 명시적으로 루트뷰에 추가
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signButton)
        
        //3. 크기와 위치 및 속성 정의
        //Frame 기반
        emailTextField.frame = CGRect(x: 50, y: 80, width: UIScreen.main.bounds.width - 100, height: 50)
        emailTextField.borderStyle = .line
        emailTextField.backgroundColor = .lightGray
        
        //NSLayoutConstraints
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false //충돌이 발생 할 수 있으니 꺼둔다
        passwordTextField.backgroundColor = .lightGray
        
//        let top = NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 100)
//        top.isActive = true
//
//        let leading = NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 50)
//        leading.isActive = true
//
//        NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: emailTextField, attribute: .trailing, multiplier: 1, constant: -50).isActive = true
//
//        NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60).isActive = true
//
        
        //NSLayoutConstraints addConstraints - AutoLayout의 기반
        let top = NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 100)
      
        
        let leading = NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 50)
       
        
        let trailing = NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: emailTextField, attribute: .trailing, multiplier: 1, constant: -50)
        
        let height = NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60)
        
        //한번에 isActive 하기
        view.addConstraints([top, leading, trailing, height])
        
        
        //4. NSLayoutAnchor
        signButton.translatesAutoresizingMaskIntoConstraints = false
        signButton.backgroundColor = .red
        
        NSLayoutConstraint.activate([
            signButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signButton.widthAnchor.constraint(equalToConstant: 300), //절대적인 값
            signButton.heightAnchor.constraint(equalToConstant: 50),
            signButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        
        
    }
    
    
}
