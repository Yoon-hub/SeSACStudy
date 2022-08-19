//
//  CustomLabel.swift
//  CodeNeflix
//
//  Created by 최윤제 on 2022/08/20.
//

import UIKit

class BoldCustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configue()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configue() {
        let weight = UIFont.Weight(20)
        self.font = .systemFont(ofSize: 17, weight: weight)
        self.textColor = .white
    }
}
