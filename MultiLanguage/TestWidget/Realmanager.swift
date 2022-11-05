//
//  Realmanager.swift
//  MultiLanguage
//
//  Created by 최윤제 on 2022/10/24.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared: RealmManager = .init()
     
    private var realm: Realm {
        let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.sesac.MultiLanguage")
        let realmURL = container?.appendingPathComponent("default.realm")
        let config = Realm.Configuration(fileURL: realmURL, schemaVersion: 1)
        return try! Realm(configuration: config)
    }
    
    func getAllMemo() -> [Memo] {
        return Array(realm.objects(Memo.self))
    }
}
