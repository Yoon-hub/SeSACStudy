//
//  BaseView.swift
//  SeSAC2Week7Diary
//
//  Created by 최윤제 on 2022/08/19.
//

import UIKit

class BaseView: UIView {
    //코드베이스 호출
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstaints()
        
    }
    //프로토콜 안에 구현
    //XIB -> nib 변경후 호출
    //?표는 실패 할수 도 있다는 의미
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") // 런타임 오류
    }
    
    func configureUI() { }
    
    func setConstaints() { }
    
}






// required initializer

protocol example {
    init(name: String)
}

class Mobile: example {
    let name: String
    
    required init(name: String) {
        self.name = name
    }
}

class Apple: Mobile {
    let wwdc: String
    
    //자기 자신을 모두 초기화 후 부모 프로퍼티를 초기화 해야한다
    init(wwdc: String) {
        self.wwdc = wwdc
        super.init(name: "모바일")
       
    }
    
    required init(name: String) {
        fatalError("init(name:) has not been implemented")
    }
}

let a = Apple(wwdc: "애플")
