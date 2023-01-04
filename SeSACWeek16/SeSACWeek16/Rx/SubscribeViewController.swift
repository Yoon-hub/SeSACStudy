//
//  SubscribeViewController.swift
//  SeSACWeek16
//
//  Created by 최윤제 on 2022/10/26.
//

import UIKit

import RxSwift
import RxCocoa
import RxAlamofire
import RxDataSources

class SubscribeViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var thottleButton: UIButton!
    
    var dispoasBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testRxAlamofire()
        textRxDataSource()
        
        thottleButton.rx.tap
            .throttle(.seconds(5), latest: false ,scheduler: MainScheduler.instance)
            .bind {
                print("안녕하세요?")
            }
            .disposed(by: dispoasBag)
        
        Observable.of(1,2,3,4,5,6,7,8,9,10)
            .skip(3) // 3개를 스킵
            .filter { $0 % 2 == 0 }
            .map { $0 * 2 }
            .subscribe { value in
                print("==\(value)")
            }
            .disposed(by: dispoasBag)
        
        //3. 네트워크 통신이나 파일 다운로드 등 백그라운드 작업?
        // 보라색 에러를 만날 수도있따
     
        
        button.rx.tap
            .observe(on: MainScheduler.instance) // 다른 쓰레드로 동작하게 변경
            .subscribe { [weak self] _ in
                self?.label.text = "안녕 하세요"
            }
            .disposed(by: dispoasBag)
        
        //4. bind 무조건 메인 쓰레드에서 동작하게, 에러가 발생하면 런타임 에러가 발생한다
        button.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.label.text = "안녕 하모니카"
            }
            .disposed(by: dispoasBag)
        
        
        //5. operator로 데이터의 stream 조작
        button.rx.tap
            .map { "안녕 반가워" }
            .share()
            .bind(to: label.rx.text)
            .disposed(by: dispoasBag)
        
        
        //6. drive traites: bind와 동일한 특성 + stream 공유 (리소스 낭비 방지, share() << 이거 까지 포함한게 drive )
        // relay는 보통 drive랑 짜꿍
        button.rx.tap
            .map {"안녕 반가워"}
            .asDriver(onErrorJustReturn: "ERROR")
            .drive(label.rx.text)
            .disposed(by: dispoasBag)
    }
    
    func testRxAlamofire() {
        //Success, Error => <Single> <- subscribe 대신해서 사용하는 네트워크 도구
        let url = APIKey.searchURL + "apple"
        request(.get, url, headers: ["Authorization": APIKey.authorization])
            .data()
            .decode(type: SearchPhoto.self, decoder: JSONDecoder())
            .subscribe { value in
                print(value.results[0].likes)
            }
            .disposed(by: dispoasBag)
    }
    
    func textRxDataSource() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>> { dataSource, tableView, IndexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(item)"
            return cell
        }
        
        dataSource.titleForHeaderInSection = { dataSource, jack in
            return dataSource.sectionModels[jack].model
        }
        
        Observable.just([
            SectionModel(model: "title", items: [1, 2, 3]),
            SectionModel(model: "title", items: [1, 2, 3]),
            SectionModel(model: "title", items: [1, 2, 3])
            
        ])
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: dispoasBag)
        

    }
}


//VM UI로직 비즈니스로직
