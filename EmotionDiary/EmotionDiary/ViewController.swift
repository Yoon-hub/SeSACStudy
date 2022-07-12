//
//  ViewController.swift
//  EmotionDiary
//
//  Created by 최윤제 on 2022/07/11.
//

import UIKit
enum Emotion: String{
    case happy = "Happy"
    case sad = "Sad"
    case love = "Love"
    case like = "Like"
    case uncomfortable = "Uncomfortable"
    case bored = "Bored"
    case gloomy = "Gloomy"
    case upset = "Upset"
    case panic = "Panic"
}

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
        
        dic[sender.currentTitle!]! += 1
        
        if sender.currentTitle! == Emotion.happy.rawValue{
            happyLabel.text = "행복해 \(dic["Happy"]!)"
        } else if sender.currentTitle! == Emotion.sad.rawValue{
            sadLabel.text = "슬퍼해 \(dic["Sad"]!)"
        } else if sender.currentTitle! == Emotion.love.rawValue{
            loveLabel.text = "사랑해 \(dic["Love"]!)"
        } else if sender.currentTitle! == Emotion.like.rawValue{
            likeLabel.text = "좋아해 \(dic["Like"]!)"
        } else if sender.currentTitle! == Emotion.uncomfortable.rawValue{
            uncomfortableLabel.text = "불편해 \(dic["Uncomfortable"]!)"
        }else if sender.currentTitle! == Emotion.bored.rawValue{
            boredLabel.text = "심심해 \(dic["Bored"]!)"
        } else if sender.currentTitle! == Emotion.upset.rawValue{
            upsetLabel.text = "속상해 \(dic["Upset"]!)"
        }else if sender.currentTitle! == Emotion.panic.rawValue{
            panicLabel.text = "당황해 \(dic["Panic"]!)"
        }else if sender.currentTitle! == Emotion.gloomy.rawValue{
            gloomyLabel.text = "우울해 \(dic["Gloomy"]!)"
        }
        
        
        
     //   updateLabel()
        
    }
//    func updateLabel(){
//        happyLabel.text = "행복해 \(dic["Happy"]!)"
//        sadLabel.text = "슬퍼해 \(dic["Sad"]!)"
//        likeLabel.text = "좋아해 \(dic["Like"]!)"
//        loveLabel.text = "사랑해 \(dic["Love"]!)"
//        uncomfortableLabel.text = "불편해 \(dic["Uncomfortable"]!)"
//        boredLabel.text = "심심해 \(dic["Bored"]!)"
//        gloomyLabel.text = "우울해 \(dic["Gloomy"]!)"
//        upsetLabel.text = "속상해 \(dic["Upset"]!)"
//        panicLabel.text = "당황해 \(dic["Panic"]!)"
//    }
    

}

