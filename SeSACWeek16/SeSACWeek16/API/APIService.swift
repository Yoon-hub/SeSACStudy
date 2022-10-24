//
//  APIService.swift
//  SeSACWeek16
//
//  Created by 최윤제 on 2022/10/20.
//

import Foundation

import Alamofire

class APIService {
    
    private init() {}
    
    static func serachPhoto(query: String, completion: @escaping (SearchPhoto?, Int?, Error?) -> Void) {
        let url = "\(APIKey.searchURL)\(query)&client_id=hgdzkLDBn9mF2QTFir_YNXK3bARd4IEqF1K79THuiFI"
        //let header: HTTPHeaders = ["Authorizaiton": APIKey.authorization]
        
        //swiftyJSON이 없는 alamofire
        AF.request(url, method: .get).responseDecodable(of: SearchPhoto.self) { response in
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let value):
                //print(value)
                completion(value, statusCode, nil)
            case .failure(let error):
                //print(error)
                completion(nil, statusCode, error)
            }
            
        }
    }
    

    
}
