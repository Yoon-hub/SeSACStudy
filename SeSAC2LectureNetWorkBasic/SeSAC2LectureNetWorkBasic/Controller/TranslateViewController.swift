//
//  TranslateViewController.swift
//  SeSAC2LectureNetWorkBasic
//
//  Created by 최윤제 on 2022/07/28.
//

//UIResponderChain > reginFirstRespoder() > becomeFirstResponder()
import UIKit

import Alamofire
import SwiftyJSON

class TranslateViewController: UIViewController {
    
    @IBOutlet weak var userInputTextView: UITextView!
    @IBOutlet weak var resultTextView: UITextView!
    
    let textViewPlaceholderText = "번역하고 싶은 문잔을 작성해주세용가리 치킨"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userInputTextView.delegate = self
        
        userInputTextView.text = textViewPlaceholderText
        userInputTextView.textColor = .lightGray
        
        userInputTextView.font = UIFont(name: "MabinogiClassicR", size: 17)
        userInputTextView.layer.borderWidth = 1
        userInputTextView.layer.borderColor = UIColor.green.cgColor
        
        resultTextView.font = UIFont(name: "MabinogiClassicR", size: 17)
        resultTextView.layer.borderWidth = 1
        resultTextView.layer.borderColor = UIColor.green.cgColor
        
        
    }
    
    func requestTranslateData(text: String) {
        
        let url = EndPoint.translateURL
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret" : APIKey.NAVER_SECRET]
        // header는 dictionarry구조
        let parameter = ["source": "ko" , "target": "en", "text": text]
        
        AF.request(url, method: .post, parameters: parameter,headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                self.resultTextView.text = json["message"]["result"]["translatedText"].rawString()
                
                let statusCode = response.response?.statusCode ?? 500
                
                if statusCode == 200{
                     
                } else {
                    self.userInputTextView.text = json["errorMessage"].stringValue
                    
                }
                
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func translateButtonClicked(_ sender: UIButton) {
        requestTranslateData(text: userInputTextView.text)
        
    }
    
}


extension TranslateViewController: UITextViewDelegate{
    // Delegate 는 동작에 관한 것들이고
    
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

