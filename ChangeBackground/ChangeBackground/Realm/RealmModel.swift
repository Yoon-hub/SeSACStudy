//
//  RealmModel.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/22.
//

import Foundation
import RealmSwift

//UserDiary: 테이블 이름
//@Persisted: Column
class UserDiary: Object {
    @Persisted var diaryTitle: String // 제목(필수)
    @Persisted var diaryContent: String?//내용 (옵션)
    @Persisted var diaryDate: Date//작성 날짜(필수)
    @Persisted var regDate: Date//등록 날짜(필수)
    @Persisted var favorite: Bool//즐겨찾기(필수)
    @Persisted var photo: String?//사진String(옵션)
    
    //PK(Primary Key): Int, UUID, ObjectID
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(diaryTitle: String, diaryCount: String?, diaryDate: Date, regDate: Date, photo: String?) {
        self.init()
        self.diaryTitle = diaryTitle
        self.diaryContent = diaryCount
        self.diaryDate = diaryDate
        self.regDate = regDate
        self.favorite = false
        self.photo = photo
    }
    
}

class UserShoppingList: Object {
    @Persisted var shopThing: String // 제목(필수)
    @Persisted var favortie: Bool
    @Persisted var checkBox: Bool
    
    //PK
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(shopThing: String) {
        self.init()
        self.shopThing = shopThing
        self.favortie = false
        self.checkBox = false
    }
    
}
