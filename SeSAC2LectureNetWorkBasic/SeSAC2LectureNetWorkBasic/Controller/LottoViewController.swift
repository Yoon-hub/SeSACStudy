//
//  LottoViewController.swift
//  SeSAC2LectureNetWorkBasic
//
//  Created by 최윤제 on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController{
    
    //LocatioViewController.self 메타 타입 구문 => "LottoViewController"
    
    
    @IBOutlet var numberLabelCollection: [UILabel]!
    
    @IBOutlet weak var numberTextField: UITextField!
    //@IBOutlet weak var lottoPickerView: UIPickerView!
    var lottoPickerView = UIPickerView()
    //코드로 뷰를 만드는 기능이 훨씬 더 많이 남았슴다
    
    let numberList: [Int] = Array(1...1025).reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lottoPickerView.dataSource = self
        lottoPickerView.delegate = self
        
        numberTextField.tintColor = .clear  // 커서 없애기
        numberTextField.inputView = lottoPickerView
        numberTextField.text = "\(numberList.first!)회차"
        requestLotto(number: numberList.first!)
        
        
        for i in numberLabelCollection{
            i.layer.cornerRadius = i.frame.width / 2
            i.clipsToBounds = true
        }
        
        
    }
    
    func requestLotto(number: Int){
        
        //AF: 200-299 status code
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        let lottoNumb = ["drwtNo1", "drwtNo2", "drwtNo3", "drwtNo4", "drwtNo5", "drwtNo6", "bnusNo"]
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
               
                for i in 0..<lottoNumb.count{
                    self.numberLabelCollection[i].text = json[lottoNumb[i]].stringValue
                }

                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        requestLotto(number: numberList[row])
        numberTextField.text = "\(numberList[row])회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }

    
}
