//
//  UserDiaryRepository.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/26.
//

import Foundation
import RealmSwift

//Repository patten
protocol UserDiaryRepositoryType {
    func fetch() -> Results<UserDiary>
    func fetchSort() -> Results<UserDiary>
    func fetchfilter() -> Results<UserDiary>
    func fetchDate(date: Date) -> Results<UserDiary>
    func updateFavorite(item: UserDiary)
    func deleteItem(itme: UserDiary)
    func addItem(item: UserDiary)
}

class UserDiaryRepository: UserDiaryRepositoryType {
    
    func fetchDate(date: Date) -> Results<UserDiary> {
       
        return localRealm.objects(UserDiary.self).filter("regDate >= %@ And regDate < %@", date, Date(timeInterval: 86400, since: date)) // NSPredicate
    }
    

    let localRealm = try! Realm()
    
    func addItem(item: UserDiary) {
        
    }
    
    func fetch() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
    }
    
    
    func fetchSort() -> Results<UserDiary> {
        localRealm.objects(UserDiary.self).sorted(byKeyPath: "regDate", ascending: true)
    }
    
    func fetchfilter() -> Results<UserDiary> {
        
        return  localRealm.objects(UserDiary.self).filter("diaryTitle = '오늘의 일기514'")
    }
    
    func updateFavorite(item: UserDiary) {
        try! localRealm.write {
            
            item.favorite.toggle()
            
            //1. 스와이프한 셀 하나만 ReloadRows 코드를 구현 => 상대적 효율적
            //2. 데이터가 병경됐으니 다시 realm에서 데이터를 가져오기 => didset 일관적 형태로 갱신
            //self.tableView.reloadRows(at: , with: <#T##UITableView.RowAnimation#>)
            
            
            //                //하나의 테이블에 특정 컬럼 전체 값을 변경
            //                self.tasks.setValue(false, forKey: "favorite")
            //
            //                //하나의 레코드에서 여러 컬럼들이 변경
            //                self.localRealm.create(UserDiary.self, value: ["objectId": self.tasks[indexPath.row].objectID, "diaryContent" : "변경 테스트", "diaryTitle" : "제목임" ], update: .modified)
        }
    }
    
    func deleteItem(itme: UserDiary) {
        removeImageFromDocument(fileName: "\(itme.objectID).jpg")
        
        try! localRealm.write {
            self.localRealm.delete(itme)
        }
        
    }
    
    func removeImageFromDocument(fileName: String) {
        //Document의 경로를 알려주는 코드
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        //세부 파일 경로. 이미지를 저장할 위치
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
        
    }
}
