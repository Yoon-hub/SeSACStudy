//
//  SubjectViewModel.swift
//  SeSACWeek16
//
//  Created by 최윤제 on 2022/10/25.
//

import Foundation

import RxSwift

struct Contact {
    var name: String
    var age: Int
    var number: String
}

class SubjectViewModel {
    
    var contactData = [
        Contact(name: "Jack", age: 23, number: "01012341234"),
        Contact(name: "Hue", age: 23, number: "01012341234"),
        Contact(name: "Real Jack", age: 23, number: "01012356234")
    ]
    
    var list = PublishSubject<[Contact]>()
    
    func fetchData() {
        list.onNext(contactData)
    }
    
    func resetData() {
        list.onNext([])
    }
    
    func newData() {
        let new = Contact(name: "고래밥", age: Int.random(in: 10...50), number: "")
        contactData.append(new)
        list.onNext(contactData)
    }
    
    func filterData(query: String) {
        let result = query != "" ? contactData.filter { $0.name.contains(query) } : contactData
        //print(new)
        list.onNext(result)
    }
}
