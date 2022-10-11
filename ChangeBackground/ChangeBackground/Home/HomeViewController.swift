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
import FSCalendar

class HomeViewController: UIViewController {
    
    let repository = UserDiaryRepository() //Realm 2.
    
    //lazy 사용 전까지 초기화가 안된다
    lazy var calendar: FSCalendar = {
        let view = FSCalendar()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        
        return view
    }() 
    
    //lazy var 형태이면 delegate랑 dataSource가 사용가능하다
    //lazy 호출이 있어야 값을 초기화하는
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        
        return view
    }() // 즉시 실행 클로저
    
    var tasks: Results<UserDiary>! {
        didSet{
            tableView.reloadData()  // 개쩐다..
        }
    }
    
    let formatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        view.addSubview(calendar)
        
        tableView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            make.topMargin.equalTo(300)
        }
        calendar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        
        }
        
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reusable)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton]
        

        
    }
    
    @objc func sortButtonClicked() {
        tasks = repository.fetchSort()

    }
    
    //realm filter query, NSPredicate
    @objc func filterButtonClicked() {
        //UIMenu
        //tasks = localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] '일기'") // [c] 대소문자 상관없이 검색

        tasks = repository.fetchfilter()
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
            transition(vc, transitionStyle: .presentFullNavigation)
        
    }
    
    func fetchRealm() {
        tasks = repository.fetch()
    }
    

}

extension HomeViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return repository.fetchDate(date: date).count
    }
    
    
    
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "새싹"
//    }
//
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        return UIImage(systemName: "star.fill")
//    }
//
    //date: yyyyMMdd hh:mm:ss => dateFormatrer
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        
        
        return formatter.string(from: date) == "220907" ? "오프라인 모임" : nil
    }

    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        tasks = repository.fetchDate(date: date)
        calendar.reloadData()
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
        cell.textLable.text = tasks[indexPath.row].diaryContent
        cell.dateLabel.text = "\(tasks[indexPath.row].regDate)"
        cell.image.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectID).jpg")
//        cell.image.kf.setImage(with: URL(string: tasks[indexPath.row].photo ?? "https://user-images.githubusercontent.com/92036498/182353809-c271f5a8-5604-40f0-abaa-1f287d80f0dd.png"))
        return cell
    }
    
    //참고. TableView Editing Mode
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favorite = UIContextualAction(style: .normal, title: "즐겨찾기") { action, view, completionHandler in
            //realm date update
            self.repository.updateFavorite(item: self.tasks[indexPath.row])
            self.fetchRealm()
        }
        
        
        
        //realm 데이터 기준
        let image = tasks[indexPath.row].favorite ? "star.fill" : "star"
        favorite.image = UIImage(systemName: image)
        favorite.backgroundColor = .systemPink

        
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favorite = UIContextualAction(style: .normal, title: "삭제") { action, view, completionHandler in
            //realm date update
            
            //let task = self.tasks[indexPath.row]
            
            self.repository.deleteItem(itme: self.tasks[indexPath.row])
        
            }
           
            self.fetchRealm()
        //realm 데이터 기준

        favorite.image = UIImage(systemName: "xmark")
        favorite.backgroundColor = .systemPink
        
        return UISwipeActionsConfiguration(actions: [favorite])
            
    }
    
    
}
