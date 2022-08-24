//
//  MainViewController.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/21.
//

import UIKit

import Kingfisher
import RealmSwift //Realm 1.

protocol SelectImageDelegate {
    func sendImageData(image: UIImage)
}

class MainViewController: UIViewController {
    
    let mainView = MainView()
    let localRealm = try! Realm()  //Realm 테이블에 데이터를 CRUD할 때, Realm 테이블 경로에 접근
    var imageURL: String!
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        mainView.changeButton.addTarget(self, action: #selector(changeButtonClicked), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        // Get on-disk location of the default Realm
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    //Realm Create Sample
    @objc func saveButtonClicked() {

        let format = DateFormatter()
        format.locale = Locale(identifier: "ko_KR")
        format.timeZone = TimeZone(abbreviation: "KST")
        format.dateFormat = "yyyyMMdd"
        let chageDate = format.date(from: mainView.dateTextField.text!)
        
        // Realm + 이미지 도큐먼트 저장
        let task = UserDiary(diaryTitle: mainView.titleTextField.text!, diaryCount: mainView.titleTextView.text, diaryDate: Date(), regDate: chageDate ?? Date(), photo: nil) // => Record 한줄 추가
        
        try! localRealm.write {
            localRealm.add(task) //Create
            print("Realm Succed")
            dismiss(animated: true)
        }
        
        if let image = mainView.backgroundImageView.image {
            saveImageToDocument(fileName: "\(task.objectID).jpg", image: image)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        //Document의 경로를 알려주는 코드
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        //세부 파일 경로. 이미지를 저장할 위치
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        //용량을 줄이기 위해 압축하는 것
        guard let data = image.jpegData(compressionQuality: 0.5) else {return}
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
        
    }
    
    @objc func changeButtonClicked() {
        let vc = ChangeViewController()
        vc.delegate = self
        vc.completionHandler = {
            self.imageURL = vc.selected
            self.mainView.backgroundImageView.image = vc.selectImage
            //self.mainView.backgroundImageView.kf.setImage(with: URL(string: vc.selected))
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MainViewController: SelectImageDelegate {
    func sendImageData(image: UIImage) {
        //self.imageURL = vc.selected
        self.mainView.backgroundImageView.image = image
        print(image)
    }
}
