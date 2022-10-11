//
//  ㅕㄴㄷㄱ.swift
//  SeSAC2Week9
//
//  Created by 최윤제 on 2022/09/01.
//

import Foundation

class UserName<T> {
    
    private var listener: ( (T) -> Void )?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ completionHandler: @escaping (T) -> () ) {
        completionHandler(value)
    }
    
}
