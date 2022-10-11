//
//  URLSession+Extension.swift
//  SeSAC2Week9
//
//  Created by 최윤제 on 2022/08/30.
//

import Foundation

extension URLSession {
    
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func customDatTask(_ endpoint: URLRequest, completionHandler: @escaping completionHandler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: completionHandler)
        task.resume()
        
        return task
    }
    
    static func request<T: Codable>(_ session: URLSession = .shared, endpoint: URLRequest, comletion: @escaping (T?
    , APIError?) -> () ) {
        session.customDatTask(endpoint) { data, response, error in
            
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
                    let result = try JSONDecoder().decode(T.self, from: data)
                    comletion(result, nil)
                } catch {
                    print(error)
                    comletion(nil, .invalidData)
                }
            }
        }
    }
    
}
