//
//  ImageSearchAPIManager.swift
//  SeSAC2LectureNetWorkBasic
//
//  Created by 최윤제 on 2022/08/05.
//

import Foundation

import Alamofire
import SwiftyJSON

//클래스 싱클턴 패턴 vc 구조체 싱글턴 패턴
class ImageSearchAPIManager {
    
    static let shared = ImageSearchAPIManager()
    
    private init() { }
    
    typealias completionHandler = (Int, [String]) -> Void
    
    func fetchImageDate(text: String, startPage: Int, completionHandler: @escaping completionHandler) {
        let newtext = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! //인코딩
        let url = EndPoint.imageSearchURL + "query=\(newtext)&display=30&start=\(startPage)" //왜 한글만 안되지?
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret" : APIKey.NAVER_SECRET]
        // header는 dictionarry구
          
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let totoal = json["total"].intValue
                
                let list = json["items"].arrayValue.map{ $0["thumbnail"].stringValue }
                
                completionHandler(totoal, list)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
