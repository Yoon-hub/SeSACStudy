//
//  CustomButton.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/22.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstatins()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setConstatins() {
        
        let view = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 80)
        self.setImage(UIImage(systemName: "star", withConfiguration: config), for: .normal)
        self.tintColor = .black
        
    }
}

