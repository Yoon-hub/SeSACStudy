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
    
    let numberList: [Int] = Array(1...CalculaterDateManager.Recent()).reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lottoPickerView.dataSource = self
        lottoPickerView.delegate = self
        
        numberTextField.tintColor = .clear  // 커서 없애기
        numberTextField.inputView = lottoPickerView
        numberTextField.text = "\(numberList.first!)회차"
       
        UserDefaults.standard.array(forKey: "\(numberList.first!)") == nil ? requestLotto(number: numberList.first!) : userDefualtDisplay(number: numberList.first!)
        
        
            
        
        for i in numberLabelCollection{
            i.layer.cornerRadius = i.frame.width / 2
            i.clipsToBounds = true
        }
        
        
    }
    
    func userDefualtDisplay(number: Int) {
        let arr = UserDefaults.standard.array(forKey: "\(number)") as! [String]
        for i in 0..<arr.count {
            numberLabelCollection[i].text = arr[i]
        }
        print("User UserDefualts ")
        
    }
    
    func requestLotto(number: Int){
        
        //AF: 200-299 status code
        let url = "\(EndPoint.lottoURL)&drwNo=\(number)"
        let lottoNumb = ["drwtNo1", "drwtNo2", "drwtNo3", "drwtNo4", "drwtNo5", "drwtNo6", "bnusNo"]
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {    
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
               
                var arr: [String] = []
                for i in 0..<lottoNumb.count{
                    self.numberLabelCollection[i].text = json[lottoNumb[i]].stringValue
                    arr.append(json[lottoNumb[i]].stringValue)
                }
                UserDefaults.standard.set(arr, forKey: "\(number)")
                
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
        
        UserDefaults.standard.array(forKey: "\(numberList[row])") == nil ? requestLotto(number: numberList[row]) : userDefualtDisplay(number: numberList[row])
        
        numberTextField.text = "\(numberList[row])회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }

    
}
