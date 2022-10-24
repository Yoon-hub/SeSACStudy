//
//  test.swift
//  MultiLanguage
//
//  Created by 최윤제 on 2022/10/24.
//

import Foundation

import RealmSwift


final class Memo: Object {
    @Persisted var content: String
    
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(content: String) {
        self.init()
        self.content = content
    }
    
}

