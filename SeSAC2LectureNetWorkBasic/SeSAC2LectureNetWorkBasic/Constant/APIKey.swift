//
//  APIKey.swift
//  SeSAC2LectureNetWorkBasic
//
//  Created by 최윤제 on 2022/08/02.
//

import Foundation

struct APIKey {
    static let BOXOFFICE = "f5eef3421c602c6cb7ea224104795888"
    static let NAVER_ID = "PRSiDYYYYsQEzn5RaP2j"
    static let NAVER_SECRET = "IRfQnsa4U1"
}
    
struct EndPoint {
    static let boxofficeURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    static let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber"
    static let translateURL = "https://openapi.naver.com/v1/papago/n2mt"
}
