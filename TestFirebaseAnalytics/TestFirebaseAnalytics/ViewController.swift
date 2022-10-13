//
//  ViewController.swift
//  TestFirebaseAnalytics
//
//  Created by 최윤제 on 2022/10/11.
//

import UIKit
import FirebaseAnalytics


class ViewController: UIViewController {
    
    let jsonSample = """
  {
    "blogName": "천원의 개발",
    "userID": "1000원"
    "number" : 111
  }
  """

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        guard let data = jsonSample.data(using: .utf8) else {
            print("data ERROR")
            return
            
        }
        
        do {
            let value = try JSONDecoder().decode(BlogInfo.self, from: data)
            print(value)
        } catch {
            print(error)
        }
        
    }
    

}


struct BlogInfo: Decodable {
    let blogName, userID: String
    let number: Int
}
