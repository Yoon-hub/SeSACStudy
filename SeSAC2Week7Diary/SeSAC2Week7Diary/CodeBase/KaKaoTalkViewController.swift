//
//  KaKaoTalkViewController.swift
//  SeSAC2Week7Diary
//
//  Created by 최윤제 on 2022/08/17.
//

import UIKit
import SnapKit

class KaKaoTalkViewController: UIViewController {
    
    let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "background")
        return view
    }()
    
    let toneDownView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.layer.opacity = 0.4
        
        return view
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.layer.opacity = 0.4
        return view
    }()
    
    let chatButton: UIButton = {
        let button = UIButton()
        button.setButton(systemName: "message.fill")
        return button
    }()
    
    let editingLButton: UIButton = {
        let button = UIButton()
        button.setButton(systemName: "pencil")
        return button
    }()
    
    let kakaoStroyButton: UIButton = {
       let button = UIButton()
        button.setButton(systemName: "link")
        return button
    }()
    
    let chatLabel: UILabel = {
        let label = UILabel()
        label.setLable(title: "나와의 채팅")
        return label
    }()
    
    let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        return imageView
    }()
    let editingLabel = UILabel()
    let kakaoStoryLable = UILabel()
    let nameLabel = UILabel()
    
    let gearButton: UIButton = {
       let button = UIButton()
        button.setButton(systemName: "gearshape.circle")
        button.layer.opacity = 0.6
        return button
    }()
    
    let diceButton: UIButton = {
        let button = UIButton()
         button.setButton(systemName: "circle.grid.3x3.circle")
         button.layer.opacity = 0.8
         return button
    }()
    
    let heartButton: UIButton = {
        let button = UIButton()
         button.setButton(systemName: "heart.circle")
         button.layer.opacity = 0.8
         return button
    }()
    
    
    let xButton: UIButton = {
        let button = UIButton()
        button.setButton(systemName: "xmark")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editingLabel.setLable(title: "프로필 편집")
        kakaoStoryLable.setLable(title: "카카오스토리")
        nameLabel.setLable(title: "최윤제")
        nameLabel.font = .boldSystemFont(ofSize: 17)
        
        [backgroundImageView, toneDownView, chatButton, editingLButton, kakaoStroyButton, chatLabel, editingLabel, kakaoStoryLable, lineView, nameLabel, profileImageView, gearButton, diceButton, heartButton, xButton].forEach{
            view.addSubview($0)
        }
        setUI()
        
        
    }
    
    func setUI() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.trailing.equalTo(view)
            make.leading.equalTo(view)
            make.bottom.equalTo(view)
        }
        toneDownView.snp.makeConstraints {  make in
            make.top.equalTo(view)
            make.trailing.equalTo(view)
            make.leading.equalTo(view)
            make.bottom.equalTo(view)
        }
        
        editingLButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        
        chatButton.snp.makeConstraints { make in
            make.trailing.equalTo(editingLButton.snp.leading).offset(-80)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        kakaoStroyButton.snp.makeConstraints { make in
            make.leading.equalTo(editingLButton.snp.trailing).offset(80)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        chatLabel.snp.makeConstraints { make in
            make.centerX.equalTo(chatButton)
            make.top.equalTo(chatButton.snp.bottom).offset(10)
        }
        editingLabel.snp.makeConstraints { make in
            make.centerX.equalTo(editingLButton)
            make.top.equalTo(editingLButton.snp.bottom).offset(10)
        }
        kakaoStoryLable.snp.makeConstraints { make in
            make.centerX.equalTo(kakaoStroyButton)
            make.top.equalTo(kakaoStroyButton.snp.bottom).offset(10)
            
        }
        lineView.snp.makeConstraints { make in
            make.trailing.equalTo(view)
            make.leading.equalTo(view)
            make.bottom.equalTo(editingLButton.snp.top).offset(-20)
            make.height.equalTo(1)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(lineView.snp.top).offset(-40)
            
        }
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(nameLabel.snp.top).offset(-10)
            make.width.equalTo(view).multipliedBy(0.26)
            make.height.equalTo(profileImageView.snp.width)
        }
        
        gearButton.snp.makeConstraints { make in
            make.trailing.equalTo(view).offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.height.equalTo(30)
            make.width.equalTo(30)

        }
        diceButton.snp.makeConstraints { make in
            make.top.equalTo(gearButton.snp.top)
            make.trailing.equalTo(gearButton.snp.leading).offset(-10)
            make.height.equalTo(30)
            make.width.equalTo(30)
            
        }
        
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(gearButton.snp.top)
            make.trailing.equalTo(diceButton.snp.leading).offset(-10)
            make.height.equalTo(30)
            make.width.equalTo(30)
            
        }
        
        xButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.leadingMargin.equalTo(20)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
    }

    
}
