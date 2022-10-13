//
//  User.swift
//  TestFirebaseAnalytics
//
//  Created by 최윤제 on 2022/10/13.
//

import Foundation

import RealmSwift

class User: Object {
    @Persisted var name: String
    @Persisted var location: String
    @Persisted var age: Int
    @Persisted var phoneNumber: Int
    @Persisted var introduce: String // 초기값 포함하여 추가
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(name: String, address: String, age: Int) {
        self.init()
        self.name = name
        self.location = address
        self.age = age
    }
}
