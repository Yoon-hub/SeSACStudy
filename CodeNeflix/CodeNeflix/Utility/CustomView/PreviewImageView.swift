//
//  PreviewImageView.swift
//  CodeNeflix
//
//  Created by 최윤제 on 2022/08/20.
//

import UIKit


class PreviewImageView: UIImageView {
    
    override init(image: UIImage?) {
        super.init(image: image)
        configue()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configue() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = ((UIScreen.main.bounds.width - 8 * 4)/3) / 2
        self.layer.masksToBounds = true
    }
}
