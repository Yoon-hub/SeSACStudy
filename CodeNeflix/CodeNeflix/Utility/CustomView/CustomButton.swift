//
//  CustomButton.swift
//  CodeNeflix
//
//  Created by 최윤제 on 2022/08/21.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configue()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configue() {
        self.backgroundColor = .white
        self.setTitle("회원가입", for: .normal)
        self.setTitleColor(UIColor.black, for: .normal)
        self.layer.cornerRadius = 10
    }
    
}
