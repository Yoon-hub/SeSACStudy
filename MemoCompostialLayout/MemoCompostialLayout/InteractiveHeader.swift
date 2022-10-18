//
//  InteractiveHeader.swift
//  MemoCompostialLayout
//
//  Created by 최윤제 on 2022/10/19.
//

import UIKit
import SnapKit

class InteractiveHeader: UICollectionReusableView {
    
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func configure() {
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.center
        }
    }
}
