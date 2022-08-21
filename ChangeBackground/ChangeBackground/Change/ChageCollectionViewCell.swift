//
//  ChageCollectionViewCell.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/22.
//

import UIKit
import SnapKit

class ChageCollectionViewCell: UICollectionViewCell {
    
    var imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
       
        configure()
        setConstatins()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        [imageView].forEach{ self.addSubview($0) }
    }
    
    func setConstatins() {
        imageView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalTo(self)
        }
    }


}
