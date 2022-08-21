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
    
    static func requestImage(search: String, page: Int, completionHandler) {
        //https://api.unsplash.com/search/photos/?query=office&page=1&client_id=hgdzkLDBn9mF2QTFir_YNXK3bARd4IEqF1K79THuiFI
        let url = "\(APIKey.endPoint)query=\(search)&page=\(page)&client_id=\(APIKey.key)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
