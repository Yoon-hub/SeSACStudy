//
//  ViewController.swift
//  TestFirebaseAnalytics
//
//  Created by 최윤제 on 2022/10/11.
//

import UIKit

//struct BlogInfo: Decodable {
//    let name, user: String
//    let number: Int
//
//    enum CodingKeys: String, CodingKey {
//        case name = "blogName"
//        case user = "userID"
//        case number
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.name = "이름: " + (try container.decode(String.self, forKey: .name))
//        self.user = "유저ID: " + (try container.decode(String.self, forKey: .user))
//        self.number = try container.decode(Int.self, forKey: .number)
//    }
//}

struct User: Encodable {
    let name: String
    let nickName: String
    let age: Int
}

class ViewController: UIViewController {
    
    let users: [User] = [
        User(name: "철수", nickName: "김철수", age: 7),
        User(name: "짱구", nickName: "신짱구", age: 7),
        User(name: "짱아", nickName: "신짱아", age: 3)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        do {
            let jsonData = try JSONEncoder().encode(users)
            
            guard let jsonString = String(data: jsonData, encoding: .utf8) else { return }
            print(jsonString)
        } catch {
            print(error)
        }
        
    }
}



