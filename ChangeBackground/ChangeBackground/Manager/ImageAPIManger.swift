//
//  ImageAPIManger.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/22.
//

import Foundation

import Alamofire
import SwiftyJSON

struct ImageAPIManager {
    
    static func requestImage(search: String, page: Int, completionHandler: @escaping ([String], (Int))->() ) {
    
        let url = "\(APIKey.endPoint)query=\(search)&page=\(page)&client_id=\(APIKey.key)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var list: [String] = []
                let totalPage = json["total_pages"].intValue
                
                for i in json["results"].arrayValue {
                    list.append(i["urls"]["raw"].stringValue)
                }
                
                completionHandler(list, totalPage)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
