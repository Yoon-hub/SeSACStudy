//
//  RxCocoaExampleViewController.swift
//  SeSACWeek16
//
//  Created by 최윤제 on 2022/10/24.
//

import UIKit

import RxCocoa
import RxSwift

class RxCocoaExampleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var sampleSwitch: UISwitch!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        setPickerView()
        setSwitch()
        setSign()
        setOperator()
    }
    
    func setOperator() {
        
        Observable.repeatElement("Jack")
            .take(5)
            .subscribe { value in
                print("repeat - \(value)")
            }
        
        let intervalObservable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance) // 1초마다 방출
            .subscribe { value in
                print("interval - \(value)")
            } onError: { error in
                print("interval - \(error)")
            } onCompleted: {
                print("interval - completed")
            } onDisposed: {
                print("interval - disposed")
            }
            //.disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            intervalObservable.dispose() // 수동으로 정지
        }
        
        
        let itemsA = [3.3, 4.0, 5.0, 2.0, 3.6, 4.8]
        let itemsB = [2.3, 2.0, 1.3, 4.6]
        
        Observable.just(itemsA)
            .subscribe { value in
                print("just - \(value)")
            } onError: { error in
                print("just - \(error)")
            } onCompleted: {
                print("just - completed")
            } onDisposed: {
                print("just - disposed")
            }
            .disposed(by: disposeBag)

        
        Observable.of(itemsA, itemsB) // of 는 여러개를 넣을 수 잇다
            .subscribe { value in
                print("of - \(value)")
            } onError: { error in
                print("of - \(error)")
            } onCompleted: {
                print("of - completed")
            } onDisposed: {
                print("of - disposed")
            }
            .disposed(by: disposeBag)
        
        Observable.from(itemsA)
            .subscribe { value in
                print("from - \(value)")
            } onError: { error in
                print("from - \(error)")
            } onCompleted: {
                print("from - completed")
            } onDisposed: {
                print("from - disposed")
            }
            .disposed(by: disposeBag)
    }
    
    func setSign() {
        
        //ex. textField1(Observable), textField2(Observable) > 레이블(Observer, bind)
        //반응형 코드 좋구나
        //bind 는 next 이벤트만 전달 된다 subscribe는 여러개
        Observable.combineLatest(nameTextField.rx.text.orEmpty, emailTextField.rx.text.orEmpty) { value1, value2 in
            return "name은 \(value1)이고, 이메일은 \(value2)입니다"
        }
        .bind(to: label.rx.text)
        .disposed(by: disposeBag)
        
        nameTextField // UITextFiled
            .rx //Reactive
            .text // String?
            .orEmpty // String
            .map { $0.count } // Int
            .map { $0 < 4 } // Bool
            .bind(to: emailTextField.rx.isHidden) // bind 쉼표로 두개도 가능
            .disposed(by: disposeBag)
        
        emailTextField.rx.text.orEmpty
            .map{ $0.count > 4 }
            .bind(to: signButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signButton.rx.tap
            .subscribe { _ in
                let alert = UIAlertController(title: "로그인성공", message: nil, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .cancel)
                alert.addAction(ok)
                self.present(alert, animated: true)
        
            }
            .disposed(by: disposeBag)
    }
    
    func setTableView() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
        ])

        items
        .bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element) @ row \(row)"
            return cell
        }
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self) // 옵저버블등록
            .map{ data in  // map을 통해서 text를 변경 해준다
                "\(data)를 클릭했습니다."
                
            }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)

        
    }
    
    func setPickerView() {
        
        let items = Observable.just([
                "영화",
                "애니메이션",
                "드라마",
                "기타"
            ])
     
        items
            .bind(to: pickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        pickerView.rx.modelSelected(String.self)
            .map{ $0.first }
            .bind(to: label.rx.text)
//            .subscribe(onNext: { value in
//                print(value)
//            })
            .disposed(by: disposeBag)
        
    }
    
    func setSwitch() {
        Observable.just(false)
            .bind(to: sampleSwitch.rx.isOn)
            .disposed(by: disposeBag)
            
    }

}
