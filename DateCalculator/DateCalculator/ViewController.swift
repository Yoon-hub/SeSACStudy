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
    
    var labelArr : [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for i in imageCollection{
            i.layer.cornerRadius = 25
        }
        updateDate()
        
    
        
        
        
        //DateFormatter: 알아보기 쉬운 날짜 + 시간대 (yyyy MM dd hh:mm:ss)
//        let format = DateFormatter()
//        format.dateFormat = "M월 d일, yy년"  // format을 이형태로 하겠다
//
//        let result = format.string(from: Date())
//
//        let word = "3월 2일, 19년"
//        let dateResult = format.date(from: word)
    }
    
    func updateDate() {
        
        let format = DateFormatter()
        format.locale = Locale(identifier: "ko_KR")  // 한국시간으로 변경
        format.timeZone = TimeZone(abbreviation: "KST") // 한국시간으로 변경
        format.dateFormat = "yyyy년\n MM월 d일"
        
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

