//
//  Realm.swift
//  SeSAC2LectureNetWorkBasic
//
//  Created by 최윤제 on 2022/08/22.
//

import Foundation
import RealmSwift

class BoxOfficeInfo: Object {

    @Persisted var date: String
    @Persisted var movieTitle: String
    @Persisted var releaseData: String
    @Persisted var totalCount: String
    
    //PK(Primary Key): Int, UUID, ObjectID
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(date: String, movieTitle: String, releaseData: String, totalCount: String) {
        self.init()
        self.date = date
        self.movieTitle = movieTitle
        self.releaseData = releaseData
        self.totalCount = totalCount
    }
    
}
