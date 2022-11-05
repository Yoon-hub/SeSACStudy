//
//  MigrationViewController.swift
//  TestFirebaseAnalytics
//
//  Created by 최윤제 on 2022/10/13.
//

import UIKit

import RealmSwift

class MigrationViewController: UIViewController {
    
    let localRealm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //inputSampleData()
        
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
        
        let current = Date()
        
        let todayMonth = Calendar.current.dateComponents([.month, .year, .day], from: current)
        
                                                
        
        var dateComponents = DateComponents(hour: 00)
        dateComponents.year = todayMonth.year
        dateComponents.month = todayMonth.month
        dateComponents.day = todayMonth.day! + 1
        dateComponents.hour = dateComponents.hour! + 24
        
        
        let date = Calendar.current.date(from: dateComponents)
        print("++++++++++++++++++++++++\(date)++++++++++++++++")
        print("++++++++++++++++++++++++\(current)++++++++++++++++")
        
        let format = DateFormatter()
        format.locale = Locale(identifier: "ko_KR")
        format.timeZone = TimeZone(abbreviation: "KST")
        format.dateFormat = "yyyy년 MM월 dd일 EEEE a hh:mm"
        print(format.string(from: date!))
    }
    
    func inputSampleData() {
        
        let local = ["서울", "대구", "인천", "부산", "울산", "광주", "대전"]
        
        for i in 1...50 {
            let user = User(name: "김철수" + String(i), address: local.randomElement()!, age: i + 20)
            
            try! localRealm.write {
                localRealm.add(user)
            }
        }
        
 
        
    }

}
