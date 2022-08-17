//
//  FisrtViewController.swift
//  SeSAC2Week7Diary
//
//  Created by 최윤제 on 2022/08/16.
//

import UIKit

class FisrtViewController: UIViewController {

    @IBOutlet weak var tutorialLabel: UILabel!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tutorialLabel.numberOfLines = 0
        tutorialLabel.font = .boldSystemFont(ofSize: 25)
        tutorialLabel.text = """
        일기를 씁시다!
        잘 써봅시다
        """
        tutorialLabel.backgroundColor = .red
        blackView.backgroundColor = UIColor.black
        blackView.alpha = 0
        tutorialLabel.alpha = 0
        
        UIView.animate(withDuration: 3) {
            self.tutorialLabel.alpha = 1
            self.tutorialLabel.backgroundColor = .yellow
            
        } completion: { _ in
            self.animateBalckView()
        }

    }
    
    func animateBalckView() {
        UIView.animate(withDuration: 3) {
            self.blackView.transform = CGAffineTransform(scaleX: 3, y: 1)  // 크기를 키우가나 줄임
            self.blackView.alpha = 1
        } completion: { _ in
            self.animateImageView()
        }
    }
    
    func animateImageView() {
        //delay 몇초 뒤, withDuration 몇초 동안, options 반복을 선택
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
            self.imageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.imageView.tintColor = .blue
        } completion: { _ in
            
        }

    }
}
