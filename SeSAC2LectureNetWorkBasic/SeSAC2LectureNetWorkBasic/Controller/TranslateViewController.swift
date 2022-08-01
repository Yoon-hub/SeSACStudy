//
//  TranslateViewController.swift
//  SeSAC2LectureNetWorkBasic
//
//  Created by 최윤제 on 2022/07/28.
//

//UIResponderChain > reginFirstRespoder() > becomeFirstResponder()
import UIKit

class TranslateViewController: UIViewController {

    @IBOutlet weak var userInputTextField: UITextView!
    
    let textViewPlaceholderText = "번역하고 싶은 문잔을 작성해주세용가리 치킨"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userInputTextField.delegate = self
        
        userInputTextField.text = textViewPlaceholderText
        userInputTextField.textColor = .lightGray
    
        userInputTextField.font = UIFont(name: "MabinogiClassicR", size: 17)
        
    }
    
}

extension TranslateViewController: UITextViewDelegate{
    
    //택스트뷰의 텍스트가 변할 때마다 호출
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
    }
    
    //편집이 시작될 때, 커서가 시작될 떄
    //텍스트뷰 글자: 플레이스 홀더랑 글자가 같으면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Begin")
        
        if textView.textColor == .lightGray{
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    //편집이 끝났을 떄
    //텍스트뷰 글자 : 사용자가 아무 글자도 안 썻으면 플레이스 홀더 글자 보이게 해!
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End")
        
        if textView.text.isEmpty{
            textView.text = textViewPlaceholderText
            textView.textColor = .lightGray
        }
    }
}
