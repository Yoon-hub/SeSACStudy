//
//  ViewController.swift
//  SeSAC2Week18
//
//  Created by 최윤제 on 2022/11/02.
//

import UIKit
import RxSwift

//propertyWrapper << userdefault에 사용하면 이쁘다


class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    let viewModel = ProfileViewModel()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        APIService().login()
//        
        viewModel.profile // <Single>, Syntax Sugar
            .withUnretained(self)
            .subscribe { vc, value in
                vc.label.text = value.user.email
            } onError: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
        viewModel.getProfile()
        checkCow()
    }
    
    //Copy or Write? 값 타입이여도 참조를 하는 경우가 있따
    
    func checkCow() {
        
        var test = "jack" // 스트링은 구조체 구조체는 값타입
        address(&test) // in out 매개변수

        
        print(test[test.index(test.startIndex, offsetBy: 2)])
        
        var test2 = test // 값타입이라 메모리 주소가 바뀐다
        address(&test2)
        
        test2 = "sesac"
        address(&test)
        address(&test2)
        
        print("++_+_+_+_+_+_+_+_+_+_+_+_")
        
        var array = Array(repeating: "a", count: 100) // Collection -> Copy and write로 성능을 최적화 하고있다.
        address(&array)
        
        var newArray = array // 실제로 복사 안함! 원본을 공유하고 있음!
        address(&newArray)
        
        newArray[0] = "b" // 실제로 수정 되었을때 메모리가 새로운 주소에 할당된다.
        
        address(&array)
        address(&newArray)
    }
    
    func address(_ value: UnsafeRawPointer) {
        let address = String(format: "%p", Int(bitPattern: value))
        print(address)
    }
    
    
}

