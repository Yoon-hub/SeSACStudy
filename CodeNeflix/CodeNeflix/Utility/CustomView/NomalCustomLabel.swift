//
//  NomalCustomLabel.swift
//  CodeNeflix
//
//  Created by 최윤제 on 2022/08/20.
//

import UIKit

class NomalCustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.textColor = .white
        self.font = .boldSystemFont(ofSize: 14)
    }
    
}
