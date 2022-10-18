//
//  LottoAPIManager.swift
//  SeSAC2Week9
//
//  Created by 최윤제 on 2022/08/30.
// API - 고유한 기능을 가진 모든 소프트웨어를 통칭 하는 말

import UIKit

//shared - 단순한. 커스텀x. 응답 클로저. 백그라운드x
//default configuration - shared 설정 유사. 커스텀O(셀룰러 연결 여부, 타임 아웃 간격). 응답 클로저 + 딜리게이트

enum APIError: Error {
    case invalidRessponse
    case noData
    case failedRequest
    case invalidData
    }

class LottoAPIManager: UIViewController, URLSessionDataDelegate {
    
    static func requestLottot(drwNo: Int, comletion: @escaping (Lotto?, APIError?) -> () ) {
        
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)")!
        
        let config = URLSessionConfiguration.default
       
                
        let Task = URLSession.shared.dataTask(with: url)
        
    }
    
}

