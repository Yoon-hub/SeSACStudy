//
//  HomeViewController.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/22.
//

import UIKit
import SnapKit
import RealmSwift //Realm 1.

class HomeViewController: UIViewController {
    
    let localRealm = try! Realm() //Realm 2.
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Realm 3. Realm 데이터를 정령해 tasks에 저장
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //화면 갱신은 화면 전화 코드 및 생명 주기 실행
        //present, overCurrentContext, overFullScreen > viewVillAppear X
        //tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
        tableView.reloadData()
    }
    
    @objc
    func plusButtonClicked() {
        let vc = MainViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = tasks[indexPath.row].diaryTitle
        return cell
    }
    
    
    
}
