//
//  HomeViewController.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/22.
//

import UIKit
import SnapKit
import RealmSwift //Realm 1.
import SwiftyJSON
import CoreAudio

class HomeViewController: UIViewController {
    
    let localRealm = try! Realm() //Realm 2.
    
    //lazy var 형태이면 delegate랑 dataSource가 사용가능하다
    //lazy 호출이 있어야 값을 초기화하는
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .black
        
        return view
    }() // 즉시 실행 클로저
    
    var tasks: Results<UserDiary>! {
        didSet{
            tableView.reloadData()  // 개쩐다..
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reusable)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton]
        
    }
    
    @objc func sortButtonClicked() {
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "regDate", ascending: true)

    }
    
    //realm filter query, NSPredicate
    @objc func filterButtonClicked() {
        //UIMenu
        //tasks = localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] '일기'") // [c] 대소문자 상관없이 검색

        tasks = localRealm.objects(UserDiary.self).filter("diaryTitle = '오늘의 일기514'")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //화면 갱신은 화면 전화 코드 및 생명 주기 실행
        //present, overCurrentContext, overFullScreen > viewVillAppear X
        //tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
        
        //Realm 3. Realm 데이터를 정령해 tasks에 저장
        fetchRealm()
    }
    
    @objc
    func plusButtonClicked() {
        let vc = MainViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchRealm() {
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reusable, for: indexPath) as! HomeTableViewCell
        cell.titleLable.text = tasks[indexPath.row].diaryTitle
        cell.textLable.text = tasks[indexPath.row].diaryTitle
        cell.dateLabel.text = "\(tasks[indexPath.row].regDate)"
        return cell
    }
    
    //참고. TableView Editing Mode
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favorite = UIContextualAction(style: .normal, title: "즐겨찾기") { action, view, completionHandler in
            //realm date update
            
            try! self.localRealm.write {
                self.tasks[indexPath.row].favorite = !self.tasks[indexPath.row].favorite
                //1. 스와이프한 셀 하나만 ReloadRows 코드를 구현 => 상대적 효율적
                //2. 데이터가 병경됐으니 다시 realm에서 데이터를 가져오기 => didset 일관적 형태로 갱신
                //self.tableView.reloadRows(at: , with: <#T##UITableView.RowAnimation#>)
                self.fetchRealm()
                
//                //하나의 테이블에 특정 컬럼 전체 값을 변경
//                self.tasks.setValue(false, forKey: "favorite")
//
//                //하나의 레코드에서 여러 컬럼들이 변경
//                self.localRealm.create(UserDiary.self, value: ["objectId": self.tasks[indexPath.row].objectID, "diaryContent" : "변경 테스트", "diaryTitle" : "제목임" ], update: .modified)
            }
        }
        
        //realm 데이터 기준
        let image = tasks[indexPath.row].favorite ? "star.fill" : "star"
        favorite.image = UIImage(systemName: image)
        favorite.backgroundColor = .systemPink

        
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
    
}
