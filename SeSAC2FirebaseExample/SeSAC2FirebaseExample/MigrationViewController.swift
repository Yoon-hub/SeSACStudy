//
//  MigrationViewController.swift
//  SeSAC2FirebaseExample
//
//  Created by 최윤제 on 2022/10/13.
//

import UIKit
import RealmSwift

class MigrationViewController: UIViewController {
    
    let localRealm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        //1. default.realm 파일 fileURL
        let fileURL = localRealm.configuration.fileURL
        print("FileURL: \(fileURL)")
        
        //2. SchemaVersion 확인
        do {
            let version = try schemaVersionAtURL(fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
        
        //3. Test
//        for i in 1...100 {
//            let task = Todo(title: "고래밥의 할일 \(i)", favorite: Int.random(in: 1...5))
//
//            try! localRealm.write {
//                localRealm.add(task)
//            }
//
//        }
        
        
     
    }

}
