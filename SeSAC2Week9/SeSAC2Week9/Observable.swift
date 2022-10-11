//
//  Observable.swift
//  SeSAC2Week9
//
//  Created by 최윤제 on 2022/08/31.
//

import Foundation
//didset은 데이터 바인딩 한 방향으로
class Observable<T> { // 양방향 바인딩
    
    private var listener: ( (T) -> () )?  // listener는 did set에서 항상 실행 될 수 있도록 만든것

    var value: T {
        didSet {
            print("didset", value)
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> () ) {
        print(#function)
        closure(value)
        listener = closure
    }
    
}

class User {

    private var listener: ( (String) -> () )?
    
    var value: String {
        didSet {
            print("데이터 바뀌없어")
            listener?(value)
        }
    }
    //와일드 카드 식별자
    init(value: String) {
        self.value = value
    }
    
}
