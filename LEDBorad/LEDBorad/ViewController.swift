//
//  ViewController.swift
//  LEDBorad
//
//  Created by 최윤제 on 2022/07/06.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var textColorButton: UIButton!
    @IBOutlet weak var sendButtton: UIButton!
    @IBOutlet weak var topView: UIView!
    

    @IBOutlet var buttonList: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        designButton(buttonOutlet: sendButtton, title: "전송")
        designTextField()
        
        
    }
    
    
    func designTextField() {
        userTextField.placeholder = "내용을 작성해주세요"
        userTextField.text = "안녕하세요"
        userTextField.keyboardType = UIKeyboardType.emailAddress
    }
    
    //외부 매개변수 argument Label -> 생략가능
    //내부 매개변수 parameter Name
    //_ : 와일드 카드 식별자
    func designButton(buttonOutlet buttonName: UIButton, title: String){
        buttonName.setTitle(title, for: .normal)
        buttonName.setTitle("빨리보내!", for: .highlighted)
        buttonName.backgroundColor = .yellow
        buttonName.layer.cornerRadius = 8
        buttonName.layer.borderColor = UIColor.black.cgColor
        buttonName.layer.borderWidth = 3
        buttonName.setTitleColor(.red, for: .normal)
        buttonName.setTitleColor(.blue, for: .highlighted)
        
        let buttonArray = [sendButtton, textColorButton]
        
        for item in buttonList{
            item.backgroundColor = .blue
            item.layer.cornerRadius = 2
        }
        //우웃렛 컬렉션
    }
    

    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        
        resultLabel.textColor = .blue
        resultLabel.text = userTextField.text
        
    }
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        
        if topView.isHidden{
            topView.isHidden = false
        } else {
            topView.isHidden = true
        }
       
    }
    
    @IBAction func endEditing(_ sender: UITextField) {
        view.endEditing(true)
        sendButtonClicked(sendButtton)
    }
    
    
}

