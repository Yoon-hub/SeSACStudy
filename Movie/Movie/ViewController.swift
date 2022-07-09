//
//  ViewController.swift
//  Movie
//
//  Created by 최윤제 on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image3: UIImageView!
    
    
    @IBOutlet var movieImageView: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //image1.layer.cornerRadius = image1.frame.height/2
        
        let imageArray = [image1, image2, image3]
        
        for i in imageArray{
            i?.layer.cornerRadius = image1.frame.width / 2
            i?.layer.borderWidth = 1.5
            i?.layer.borderColor = UIColor.lightGray.cgColor
        }
    

        
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        movieImageView.image = UIImage(named: "movie\(Int.random(in: 1...5))")
    }
    
}


