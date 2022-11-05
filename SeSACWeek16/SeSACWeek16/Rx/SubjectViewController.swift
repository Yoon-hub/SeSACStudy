//
//  SubjectViewController.swift
//  SeSACWeek16
//
//  Created by 최윤제 on 2022/10/25.
//

import UIKit

import RxSwift
import RxCocoa

class SubjectViewController: UIViewController {
    
    let publish = PublishSubject<Int>() // 초기값이 없는 빈 상태
    let behavior = BehaviorSubject(value: 100) // Publish랑 똑같지만 초기값이 필수
    let replay = ReplaySubject<Int>.create(bufferSize: 3) // bufferSize에 작성된 이벤트 갯수만큼 메모리에서 이벤트를 가지고 있다가, subscribe 직후 한 번에 이벤트를 전달
    let async = AsyncSubject<Int>() //
    //Variable << 지금은 안사용한다
    
    let disposeBag = DisposeBag()
    let viewModel = SubjectViewModel()
    
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var newButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ContactCell")
        
        let input = SubjectViewModel.Input(addTap: addButton.rx.tap, resetTap: resetButton.rx.tap, newTap: newButton.rx.tap, searchText: searchBar.rx.text)
        let output = viewModel.transform(input: input)
        

        output.list
            .drive(tableView.rx.items(cellIdentifier: "ContactCell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element.name): \(element.age)세 (\(element.number))"
            }
            .disposed(by: disposeBag)
        
        
        output.addTap
            .withUnretained(self)
            .subscribe { vc, _ in
                vc.viewModel.fetchData()
            }
            .disposed(by: disposeBag)
        
        output.resetTap
            .withUnretained(self)
            .subscribe { vc, _ in
                vc.viewModel.resetData()
            }
            .disposed(by: disposeBag)
        
        output.newTap  // VC -> VM (Input)
            .withUnretained(self)
            .subscribe { vc, _ in
                vc.viewModel.newData()
            }
            .disposed(by: disposeBag)
        
        output.searchText
            .withUnretained(self)
            .subscribe { vc, value in
                print("===\(value)")
                vc.viewModel.filterData(query: value)
            }
            .disposed(by: disposeBag)
    }
    


}

//복습을 위한 subject 예제모음
extension SubjectViewController {
    
    func asyncSubject() { // 최휴의 한마디
        `async`.onNext(100)
        `async`.onNext(200)
        `async`.onNext(300)
        `async`.onNext(400)
        `async`.onNext(500) // 구독 전에
        
        `async`
            .subscribe { value in  // 구독하기
                print("async -\(value)")
            } onError: { error in
                print("async -\(error)")
            } onCompleted: {
                print("async - completed")
            } onDisposed: {
                print("async - dispose")
            }
            .disposed(by: disposeBag)
        
        `async`.onNext(3) // 구독 후에
        `async`.onNext(4)
        `async`.on(.next(5))
        `async`.onCompleted()
    }
    
    func replaySubject() { // BufferSize 메모리에 저장
        replay.onNext(100)
        replay.onNext(200)
        replay.onNext(300)
        replay.onNext(400)
        replay.onNext(500) // 구독 전에
        
        replay
            .subscribe { value in  // 구독하기
                print("replay -\(value)")
            } onError: { error in
                print("replay -\(error)")
            } onCompleted: {
                print("replay - completed")
            } onDisposed: {
                print("replay - dispose")
            }
            .disposed(by: disposeBag)
        
        replay.onNext(3) // 구독 후에
        replay.onNext(4)
        replay.on(.next(5))
        replay.onCompleted() // 구독취소
    }
    
    func behaviorSubject() { // 구독하기 직전에값을 emit 하기 때문에 초기값이 필수
        behavior.onNext(1)
        behavior.onNext(2) // 구독 전에
        
        behavior
            .subscribe { value in  // 구독하기
                print("behavior -\(value)")
            } onError: { error in
                print("behavior -\(error)")
            } onCompleted: {
                print("behavior - completed")
            } onDisposed: {
                print("behavior - dispose")
            }
            .disposed(by: disposeBag)
        
        behavior.onNext(3) // 구독 후에
        behavior.onNext(4)
        behavior.on(.next(5))
        behavior.onCompleted() // 구독취소
    }
    
    func publishSubject() {  // 초기값이 없는 빈 상태 Observer + Observable
        
        
        publish.onNext(1)
        publish.onNext(2) // 구독 전에
        
        publish
            .subscribe { value in  // 구독하기
                print("publish -\(value)")
            } onError: { error in
                print("publish -\(error)")
            } onCompleted: {
                print("publish - completed")
            } onDisposed: {
                print("publish - dispose")
            }
            .disposed(by: disposeBag)
        
        publish.onNext(3) // 구독 후에
        publish.onNext(4)
        publish.on(.next(5))
        
        publish.onCompleted() // 구독취소
    }

}
