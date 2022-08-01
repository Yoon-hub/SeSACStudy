//
//  UserDefaultsHelper.swift
//  SeSAC2LectureNetWorkBasic
//
//  Created by 최윤제 on 2022/08/01.
//

import Foundation

class UserDefaultsHelper{
    
    private init() { }  // 인스턴스 생성 못하도록 private 걸어둔다 개쩐다
    
    static let standard = UserDefaultsHelper()
    // singleton pattern 자기 자신의 인스턴스를 타입 프로퍼티 형태로 가지고 있음
    
    let userDefaults = UserDefaults.standard
    
    enum key: String{
        case nickname, age
    }
    
    var nickname: String{
        get{
            return userDefaults.string(forKey: key.nickname.rawValue) ?? "대장"
        }
        
        set{
            userDefaults.set(newValue, forKey: key.nickname.rawValue)
        }
    }
    
    var age: Int{
        get{
            return userDefaults.integer(forKey: key.age.rawValue)
        }
        set{
            userDefaults.set(newValue, forKey: key.age.rawValue)
        }
    }

    
}
