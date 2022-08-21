//
//  CustomTextField.swift
//  CodeNeflix
//
//  Created by 최윤제 on 2022/08/20.
//

import UIKit

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstatins()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstatins() {
        self.backgroundColor = .darkGray
        self.textAlignment = .center
        self.textColor = .white
        self.borderStyle = .roundedRect
    }
    
    
}
