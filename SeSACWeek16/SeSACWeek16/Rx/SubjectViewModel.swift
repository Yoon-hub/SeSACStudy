//
//  SubjectViewModel.swift
//  SeSACWeek16
//
//  Created by 최윤제 on 2022/10/25.
//

import Foundation

import RxSwift
import RxCocoa

//associated type == generic
protocol CommonViewModel {
    
    associatedtype Input  // associatedtype을 사용하는 이유는 안의 프로퍼티가 달라서
    associatedtype Output
    
    func transform(input: Input) -> Output
}

struct Contact {
    var name: String
    var age: Int
    var number: String
}

class SubjectViewModel: CommonViewModel {
    
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
    
    struct Input {
        let addTap: ControlEvent<(Void)>
        let resetTap: ControlEvent<(Void)>
        let newTap: ControlEvent<(Void)>
        let searchText: ControlProperty<String?>
    }
    
    struct Output {
        let addTap: ControlEvent<(Void)>
        let resetTap: ControlEvent<(Void)>
        let newTap: ControlEvent<(Void)>
        let list: Driver<[Contact]>
        let searchText: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        let list = list.asDriver(onErrorJustReturn: [])
        
        let text = input.searchText
            .orEmpty // VC -> VM (Input)
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance) // wait 서버 콜수줄이기
            .distinctUntilChanged() //같은 값을 받지 않는 오퍼레이터
        
        return Output(addTap: input.addTap, resetTap: input.resetTap, newTap: input.newTap, list: list, searchText: text)
    }
}
