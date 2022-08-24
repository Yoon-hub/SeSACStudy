//
//  ShoppingDetailVC.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/23.
//

import UIKit
import SnapKit
import SwiftUI
import RealmSwift


class ShoppingDetailVC: UIViewController {
    
    var selectImageView = UIImageView()
    var objectId: ObjectId!
    
    
    let smallView = UIView()
    let thingLabel = UILabel()
    let favoriteLabel = UILabel()
    let checkBoxLabel = UILabel()
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fillEqually
        view.spacing = 2
        return view
    }()
    
    let imageButton: CustomButton = {
        let view = CustomButton()
        view.setImage(UIImage(systemName: "photo.artframe" ), for: .normal)
        view.tintColor = .systemPink
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        smallView.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(tapGestureClicked))
        view.addGestureRecognizer(tapGesture)
        smallView.layer.cornerRadius = 20
        selectImageView.layer.borderWidth = 1
        selectImageView.layer.borderColor = UIColor.brown.cgColor
        imageButton.addTarget(self, action: #selector(imageButtonClicked), for: .touchUpInside)
        
        configure()
        setConstatins()
    }
    
    @objc func imageButtonClicked() {
        let vc = ChangeViewController()
        vc.delegate = self
        let navi = UINavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .fullScreen
        self.present(navi, animated: true)
    }
    
    func configure() {
        view.addSubview(smallView)
        
        [stackView, selectImageView, imageButton].forEach {
            self.smallView.addSubview($0)
        }
        
        [thingLabel, favoriteLabel, checkBoxLabel].forEach {
            self.stackView.addArrangedSubview($0)
        }
        
    }
    
    func setConstatins() {
        smallView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.height.width.equalTo(view).multipliedBy(0.7)
        }
        stackView.snp.makeConstraints { make in
            make.center.equalTo(smallView)
        }
        selectImageView.snp.makeConstraints { make in
            make.centerX.equalTo(smallView)
            make.bottom.equalTo(smallView).offset(-10)
            make.height.width.equalTo(200)
        }
        imageButton.snp.makeConstraints { make in
            make.centerX.equalTo(smallView)
            make.bottom.equalTo(selectImageView.snp.bottom).offset(-10)
            make.height.width.equalTo(50)
        }
        
    }
    
    @objc func tapGestureClicked() {
        dismiss(animated: true)
    }
    
}

extension ShoppingDetailVC: SelectImageDelegate {
    
    func sendImageData(image: UIImage) {
        saveImageToDocument(fileName: "\(objectId!).jpg", image: image)
        selectImageView.image = image
    }
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        //세부 파일 경로. 이미지를 저장할 위치
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        //용량을 줄이기 위해 압축하는 것
        guard let data = image.jpegData(compressionQuality: 0.5) else {return}
        
        try! data.write(to: fileURL)

    }
    
    
}
