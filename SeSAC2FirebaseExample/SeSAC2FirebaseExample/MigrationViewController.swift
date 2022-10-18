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
        //            let task = Todo(title: "고래밥의 할일 \(i)", importance: Int.random(in: 1...5))
        //
        //            try! localRealm.write {
        //                localRealm.add(task)
        //            }
        //
        //        }
        //
        //        for i in 1...10 {
        //            let task = DetailTodo(detatilTitle: "양바 \(i)개 사기", favorite: true)
        //
        //            try! localRealm.write {
        //                localRealm.add(task)
        //            }
        //
        //        }
        
        //특정 Todo 테이블에 DetailToDo 추가
//        guard let task = localRealm.objects(Todo.self).filter("title = '고래밥의 할일 7'").first else { return }
//
//        let detail = DetailTodo(detatilTitle: "프랭크 5개 먹기", favorite: false)
//
//        try! localRealm.write {
//            task.detail.append(detail)
//        }
//
//        //특정 Todo 테이블에 여러개 DetailToDo 추가
//        guard let task = localRealm.objects(Todo.self).filter("title = '고래밥의 할일 3'").first else { return }
//
//
//        let detail2 = DetailTodo(detatilTitle: "깡깡한 아이스크림 \(Int.random(in: 1...5)) 먹기", favorite: false)
//
//        for _ in 1...10 {
//            try! localRealm.write {
//                task.detail.append(detail2)
//            }
//        }
        
        //특정 Todo 테이블 삭제
        
//        guard let task = localRealm.objects(Todo.self).filter("title = '고래밥의 할일 7'").first else { return }
//
//        try! localRealm.write({
//            localRealm.delete(task.detail)
//            localRealm.delete(task)
//        })
        
        //특정 Todo에 메모 추가
        guard let task = localRealm.objects(Todo.self).filter("title = '고래밥의 할일 6'").first else { return }
        
        let memo = Memo()
        memo.content = "이렇게 메모 내용을 추가해봅니다."
        memo.date = Date()
        
        try! localRealm.write {
            task.memo = memo
        }
    }
    
}
