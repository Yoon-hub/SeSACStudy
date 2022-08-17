//
//  KakaoAPIManager.swift
//  SeSAC2Week6
//
//  Created by 최윤제 on 2022/08/08.
//

import Foundation

import Alamofire
import SwiftyJSON

struct User {
    fileprivate let name = "고래밥" //같은 스위프트 파일에서 다른 클래스, 구조체 사용 가능. 다른 스위프트 파일은 X , 파일 단위로 구분된다고 보면 된다.
    private let age = 11 //같은 스위프트 파일내에서 같은 타입
}

extension User {
    func example() {
        print(self.name, self.age)
    }
}

class KakaoAPIManager {
    
    static let shared = KakaoAPIManager()
    
    private init() { }
    
    private let header: HTTPHeaders = ["Authorization" : "KakaoAK \(APIKey.kakao)"]
    
    func callRequest(type: EndPoint, query: String, completionHandler: @escaping (JSON) -> ()) {
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = type.requestURL + query
        
        
        //Alamofire -> URLSession Framework -> 비동기로 Request
        AF.request(url, method: .get, headers: header).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
}
