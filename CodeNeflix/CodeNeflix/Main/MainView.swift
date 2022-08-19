//
//  MainView.swift
//  CodeNeflix
//
//  Created by 최윤제 on 2022/08/19.
//

import UIKit
import SnapKit

class MainView: BaseView {
    
    let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "movie1")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let backgroundShadowImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let firstPreviewImage: PreviewImageView = {
        let view = PreviewImageView(image: UIImage(named: "movie2"))
        return view
    }()
    
    let secondPreviewImage: PreviewImageView = {
        let view = PreviewImageView(image: UIImage(named: "movie3"))
        return view
    }()
    
    let thirdPreviewImage: PreviewImageView = {
        let view = PreviewImageView(image: UIImage(named: "movie4"))
        return view
    }()
    
    let previewLabel: BoldCustomLabel = {
       let view = BoldCustomLabel()
        view.text = "미리보기"
        return view
    }()
    
    let myPickLable: NomalCustomLabel = {
        let view = NomalCustomLabel()
        view.text = "내가 찜한 컨텐츠"
        return view
    }()
    
    let myPickButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "check"), for: .normal)
        return view
    }()
    
    let playButton: UIButton = {
       let view = UIButton()
        view.setImage(UIImage(named: "play_normal"), for: .normal)
        return view
    }()
    
    let infoButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "info"), for: .normal)
        return view
    }()
    
    let infoLable: NomalCustomLabel = {
        let view = NomalCustomLabel()
        view.text = "정보"
        
        return view
    }()
    
    let nLable: BoldCustomLabel = {
        let view = BoldCustomLabel()
        view.text = "N"
        let weight = UIFont.Weight(30)
        view.font = .systemFont(ofSize: 60, weight: weight)
        
        return view
    }()
    
    let tvLabel: BoldCustomLabel = {
        let view = BoldCustomLabel()
        view.text = "TV프로그램"
        return view
    }()
    
    let movieLabel: BoldCustomLabel = {
        let view = BoldCustomLabel()
        view.text = "영화"
        return view
    }()

    let pickLable: BoldCustomLabel = {
        let view = BoldCustomLabel()
        view.text = "내가 찜한 콘텐츠"
        return view
    }()

    
    
    
    override func configure() {
        [backgroundImageView, backgroundShadowImageView, firstPreviewImage, secondPreviewImage, thirdPreviewImage, previewLabel, myPickLable, myPickButton, playButton, infoLable, infoButton, nLable, tvLabel, movieLabel, pickLable].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstaints() {
        let spacing: CGFloat = 8
        backgroundImageView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalTo(self)
        }
        
        backgroundShadowImageView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalTo(self)
        }
        
        firstPreviewImage.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(self).offset(spacing)
            make.width.height.equalTo((UIScreen.main.bounds.width - spacing * 4)/3)
        }
        
        secondPreviewImage.snp.makeConstraints { make in
            make.bottom.equalTo(firstPreviewImage.snp.bottom)
            make.leading.equalTo(firstPreviewImage.snp.trailing).offset(spacing)
            make.width.height.equalTo((UIScreen.main.bounds.width - spacing * 4)/3)
        }
        
        thirdPreviewImage.snp.makeConstraints { make in
            make.bottom.equalTo(secondPreviewImage.snp.bottom)
            make.leading.equalTo(secondPreviewImage.snp.trailing).offset(spacing)
            make.width.height.equalTo((UIScreen.main.bounds.width - spacing * 4)/3)
        }
        
        previewLabel.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(spacing)
            make.bottom.equalTo(firstPreviewImage.snp.top).offset(-spacing)
            
        }
        
        myPickLable.snp.makeConstraints { make in
            make.bottom.equalTo(previewLabel.snp.top).offset(-25)
            make.leading.equalTo(self).offset(24)
        }
        
        myPickButton.snp.makeConstraints { make in
            make.bottom.equalTo(myPickLable.snp.top).offset(-spacing)
            make.centerX.equalTo(myPickLable)
            make.height.width.equalTo(20)
        }
        
        playButton.snp.makeConstraints { make in
            make.bottom.equalTo(myPickLable)
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.5)
            make.height.equalTo(30)
        }
        
        infoLable.snp.makeConstraints{ make in
            make.bottom.equalTo(myPickLable)
            make.trailing.equalTo(self).offset(-65)
        }
        
        infoButton.snp.makeConstraints { make in
            make.bottom.equalTo(infoLable.snp.top).offset(-spacing)
            make.centerX.equalTo(infoLable)
            make.height.width.equalTo(20)
            
        }
        nLable.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(0)
            make.leading.equalTo(self).offset(spacing)
        }
        
        tvLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(nLable.snp.trailing).offset(45)
        }
        
        movieLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(tvLabel.snp.trailing).offset(30)
        }
        
        pickLable.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(30)
            make.trailing.equalTo(self).offset(-20)
        }
    
}



}
