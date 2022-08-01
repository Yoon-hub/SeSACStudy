//
//  BeerViewController.swift
//  SeSAC2LectureNetWorkBasic
//
//  Created by 최윤제 on 2022/08/01.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON


class BeerViewController: UIViewController {
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    @IBOutlet weak var beerNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestBeer()
    }
    
    func requestBeer(){
        
        let url = "https://api.punkapi.com/v2/beers/random"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                self.beerDescriptionLabel.text = json[0]["description"].stringValue
                self.beerNameLabel.text = json[0]["name"].stringValue
                
                let urlImage = URL(string: json[0]["image_url"].stringValue)
                self.beerImageView.kf.setImage(with: urlImage)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    @IBAction func changeButtonClicked(_ sender: UIButton) {
        requestBeer()
    }
    


}
