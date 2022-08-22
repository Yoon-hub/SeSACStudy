//
//  MainViewController.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/21.
//

import UIKit

import Kingfisher
import RealmSwift //Realm 1.

class MainViewController: UIViewController {
    
    let mainView = MainView()
    let localRealm = try! Realm()  //Realm 테이블에 데이터를 CRUD할 때, Realm 테이블 경로에 접근
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.changeButton.addTarget(self, action: #selector(changeButtonClicked), for: .touchUpInside)
        mainView.sampleButton.addTarget(self, action: #selector(sampleButtonClicked), for: .touchUpInside)
        
        // Get on-disk location of the default Realm
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    
    //Realm Create Sample
    @objc
    func sampleButtonClicked() {
        
        let task = UserDiary(diaryTitle: "하오늘의 일기\(Int.random(in: 1...1000))", diaryCount: "일기 테스트 내용", diaryDate: Date(), regDate: Date(), photo: nil) // => Record 한줄 추가
        
        try! localRealm.write {
            localRealm.add(task) //Create
            print("Realm Succed")
            dismiss(animated: true)
        }
        
    }
    
    @objc
    func changeButtonClicked() {
        let vc = ChangeViewController()
        vc.completionHandler = {
            self.mainView.backgroundImageView.kf.setImage(with: URL(string: vc.selected))
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
