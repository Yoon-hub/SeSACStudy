//
//  PersonAPIManager.swift
//  SeSAC2Week9
//
//  Created by 최윤제 on 2022/08/30.
//

import Foundation

class PersonAPIManager {
    
    static func requestPerson(query: String, comletion: @escaping (Person?, APIError?) -> () ) {
        
        let url = URL(string: "https://api.themoviedb.org/3/search/person?api_key=971e63e37a33e57c12d2c048d0a258c4&language=en-US&query=\(query)&page=1&include_adult=false&region=ko-KR")
        
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        
        let language = "ko-KR"
        let key = "971e63e37a33e57c12d2c048d0a258c4"
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
        URLQueryItem(name: "api_key", value: key),
        URLQueryItem(name: "query", value: query),
        URLQueryItem(name: "page", value: "1"),
        URLQueryItem(name: "region", value: language),
        ]
        
      
        
        URLSession.shared.dataTask(with: component.url!) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed Request")
                    comletion(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No Data Returend")
                    comletion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    comletion(nil, .invalidRessponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    return
                }
                
                do  {
                    let result = try JSONDecoder().decode(Person.self, from: data)
                    comletion(result, nil)
                } catch {
                    print(error)
                    comletion(nil, .invalidData)
                }
            }
            
        }.resume()
    }
}
