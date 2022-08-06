//
//  CalculaterDateManger.swift
//  SeSAC2LectureNetWorkBasic
//
//  Created by 최윤제 on 2022/08/07.
//

import UIKit

struct CalculaterDateManager {
    
    static func Recent() -> Int {
        let format = DateFormatter()
        
        format.dateFormat = "yyyyMMdd"
        format.locale = Locale(identifier: "ko_KR")
        format.timeZone = TimeZone(abbreviation: "KST")
        
        let startDate = format.date(from: "20021207")!
        let today = Date()
        
        let interval = today.timeIntervalSince(startDate)
        let days = Int( interval / 86400 ) / 7 + 1
        
        return days
    }
    
}
