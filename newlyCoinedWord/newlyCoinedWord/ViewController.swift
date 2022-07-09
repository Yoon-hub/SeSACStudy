//
//  ViewController.swift
//  newlyCoinedWord
//
//  Created by 최윤제 on 2022/07/08.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!

    
    let newWord = [ "삼귀자" : "연애를 시작하기 전 썸 단계!", "윰차" : "유명과 무명의 차이", "실매" : "실시간 매니저!", "만반잘부" : "만나서 반가워 잘부탁해!" , "꾸안꾸" : "꾸민듯 안꾸민듯!", "스불재" : "스스로 불러온 재앙!", "점메추" : "점심메뉴 추천!", "군싹" : "군침이 싹도네!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        desginTextField(searchTextField)
        let buttonArr : [UIButton] = [firstButton, secondButton, thirdButton, fourthButton]
        for i in buttonArr{
            desginButton(i)
        }
        updateButton()
        
    }
    
    func desginButton(_ button: UIButton){
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.black.cgColor
    }
    
    func desginTextField(_ textField : UITextField){
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.black.cgColor
        textField.text = "삼귀자"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) // 왼쪽에 여백주는 코드
        textField.leftViewMode = .always

    }
    
    func updateButton(){
        let buttonArr : [UIButton] = [firstButton, secondButton, thirdButton, fourthButton]
        for i in stride(from: 3, to: -1, by: -1){
            if i == 0 {
                buttonArr[i].setTitle(searchTextField.text, for: .normal)
            } else {
                buttonArr[i].setTitle(buttonArr[i-1].currentTitle, for: .normal)
            }
        }
        

    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        view.endEditing(true)
        if newWord[searchTextField.text!] != nil{
            resultLabel.text = newWord[searchTextField.text!]
            updateButton()
        } else {
            resultLabel.text = "그런 단어는 없어요!"
        }
        
        searchTextField.text = ""
    }
  
    @IBAction func endEditing(_ sender: UITextField) {
        view.endEditing(true)
        if newWord[searchTextField.text!] != nil{
            resultLabel.text = newWord[searchTextField.text!]
            updateButton()
        } else {
            resultLabel.text = "그런 단어는 없어요!"
        }
        
        searchTextField.text = ""
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func hashButtonClicked(_ sender: UIButton) {
        resultLabel.text = newWord[sender.currentTitle!]
        searchTextField.text = ""
    }
    
    
}

