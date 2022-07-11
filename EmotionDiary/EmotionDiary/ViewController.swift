//
//  ViewController.swift
//  EmotionDiary
//
//  Created by 최윤제 on 2022/07/11.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var happyLabel: UILabel!
    @IBOutlet weak var sadLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var loveLabel: UILabel!
    @IBOutlet weak var uncomfortableLabel: UILabel!
    @IBOutlet weak var boredLabel: UILabel!
    @IBOutlet weak var gloomyLabel: UILabel!
    @IBOutlet weak var upsetLabel: UILabel!
    @IBOutlet weak var panicLabel: UILabel!
    
    var dic : [String: Int] = ["Happy": 0, "Love" : 0, "Like" : 0, "Panic" : 0, "Upset" : 0, "Gloomy": 0, "Bored" : 0, "Uncomfortable" : 0, "Sad" : 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        print(sender.currentTitle!)
        dic[sender.currentTitle!]! += 1
        updateLabel()
        
    }
    func updateLabel(){
        happyLabel.text = "행복해 \(dic["Happy"]!)"
        sadLabel.text = "슬퍼해 \(dic["Sad"]!)"
        likeLabel.text = "좋아해 \(dic["Like"]!)"
        loveLabel.text = "사랑해 \(dic["Love"]!)"
        uncomfortableLabel.text = "불편해 \(dic["Uncomfortable"]!)"
        boredLabel.text = "심심해 \(dic["Bored"]!)"
        gloomyLabel.text = "우울해 \(dic["Gloomy"]!)"
        upsetLabel.text = "속상해 \(dic["Upset"]!)"
        panicLabel.text = "당황해 \(dic["Panic"]!)"
    }
    

}

