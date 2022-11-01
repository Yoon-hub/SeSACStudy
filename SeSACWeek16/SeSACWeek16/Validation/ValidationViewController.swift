//
//  ValidationViewController.swift
//  SeSACWeek16
//
//  Created by 최윤제 on 2022/10/27.
//

import UIKit

import RxSwift
import RxCocoa

//MVVM 사용자가 이벤트를 주면 mv에서 가공해서 준다

class ValidationViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var stepButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    let viewModel = ValidationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
       //observableVsSubject()
    }
    
    func bind() {
        
        //After
        let input = ValidationViewModel.Input(text: nameTextField.rx.text, tap: stepButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.validation
            .bind(to: stepButton.rx.isEnabled, validationLabel.rx.isHidden)
            .disposed(by: disposeBag)
            
        output.text
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.validText  // VM -> VC Output
            .asDriver()
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        //Before
        let validation = nameTextField.rx.text // Input
            .orEmpty
            .map { $0.count >= 9 }
            .share() // Subject, Relay

        validation
            .bind(to: stepButton.rx.isEnabled, validationLabel.rx.isHidden)
            .disposed(by: disposeBag)


        validation
            .withUnretained(self)
            .bind { vc, value in
                let color: UIColor = value ? .systemPink : .lightGray
                vc.stepButton.backgroundColor = color
            }
            .disposed(by: disposeBag)
        
        stepButton.rx.tap  // Input
            .bind { _ in
                print("Show Alert")
            }
            .disposed(by: disposeBag)
    }
    
    
    func observableVsSubject() {
        
        let sampleInt = Observable<Int>.create { observer in
            observer.onNext(Int.random(in: 1...100))
            return Disposables.create()
        }
        
        sampleInt.subscribe { value in
            print("sampleInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        sampleInt.subscribe { value in
            print("sampleInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        sampleInt.subscribe { value in
            print("sampleInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        //Stream, Sequence 데이터의 흐름 같은 말
        let testA = stepButton.rx.tap
            .map { "안녕하세요" }
            .asDriver(onErrorJustReturn: "") //drive를 사용할 수 있는 객체로 변경
        //    .share()
            
        testA
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        testA
            .drive(nameTextField.rx.text)
            .disposed(by: disposeBag)
        
        testA
            .drive(stepButton.rx.title())
            .disposed(by: disposeBag)
    }
}
