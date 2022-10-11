//
//  LottoAPIManager.swift
//  SeSAC2Week9
//
//  Created by 최윤제 on 2022/08/30.
//

import Foundation

//shared - 단순한. 커스텀x. 응답 클로저. 백그라운드x
//default configuration - shared 설정 유사. 커스텀O(셀룰러 연결 여부, 타임 아웃 간격). 응답 클로저 + 딜리게이트

enum APIError: Error {
    case invalidRessponse
    case noData
    case failedRequest
    case invalidData
    }

class LottoAPIManager {
    
    static func requestLottot(drwNo: Int, comletion: @escaping (Lotto?, APIError?) -> () ) {
        
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)")!
//        header 필요할 시
//        let request = URLRequest(url: url)
//        request.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
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
                    let result = try JSONDecoder().decode(Lotto.self, from: data)
                    comletion(result, nil)
                } catch {
                    print(error)
                    comletion(nil, .invalidData)
                }
            }
            
        }.resume()
        
    }
    
}

