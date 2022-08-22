//
//  MainView.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/21.
//

import UIKit
import SnapKit

class MainView: BaseView {
    
    let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bg")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let changeButton: UIButton = {
       let view = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 50)
        view.setImage(UIImage(systemName: "arrow.clockwise", withConfiguration: config), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let sampleButton: UIButton = {
       let view = UIButton()
        view.backgroundColor = .green
        return view
    }()
    
    override func configure() {
        [backgroundImageView, changeButton, sampleButton].forEach { self.addSubview($0) }
    }
    
    override func setContraints() {
        
        sampleButton.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.trailing.top.equalTo(self.safeAreaLayoutGuide)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(self)
        }
        changeButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-30)
            make.height.width.equalTo(40)
        }
        
    }
    
    
}
