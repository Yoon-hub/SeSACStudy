//
//  ViewController.swift
//  DateCalculator
//
//  Created by 최윤제 on 2022/07/13.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageCollection: [UIImageView]!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let format = DateFormatter()
   


    
    var labelArr : [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        format.locale = Locale(identifier: "ko_KR")  // 한국시간으로 변경
        format.timeZone = TimeZone(abbreviation: "KST") // 한국시간으로 변경
        format.dateFormat = "yyyy년\n MM월 d일"
        if let selectDate = UserDefaults.standard.string(forKey: "selectDate"){
            datePicker.date = format.date(from: selectDate)!
        }
        
        for i in imageCollection{
            i.layer.cornerRadius = 25
        }
        updateDate()

    }
    
    func updateDate() {
        
        UserDefaults.standard.set(format.string(from: datePicker.date), forKey: "selectDate") // userDefault로 저장
        
        let today = datePicker.date
        let day100 = today.addingTimeInterval(86400 * 100)
        let day200 = today.addingTimeInterval(86400 * 200)
        let day300 = today.addingTimeInterval(86400 * 300)
        let day400 = today.addingTimeInterval(86400 * 400)
        
        firstLabel.text = format.string(from: day100)
        secondLabel.text = format.string(from: day200)
        thirdLabel.text = format.string(from: day300)
        fourthLabel.text = format.string(from: day400)
  
    }
    
    @IBAction func selectDate(_ sender: UIDatePicker) {
        updateDate()
    }
    
}

