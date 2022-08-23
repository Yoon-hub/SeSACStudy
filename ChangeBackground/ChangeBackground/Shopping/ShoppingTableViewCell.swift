//
//  ShoppingTableViewCell.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/22.
//

import UIKit
import SnapKit

class ShoppingTableViewCell: UITableViewCell {
    
    let starButton: CustomButton = {
        let view = CustomButton()
        return view
    }()
    
    let checkButton: CustomButton = {
        let view = CustomButton()
        view.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        return view
    }()
    
    let label: UILabel = {
       let view = UILabel()
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [starButton, checkButton, label].forEach{ contentView.addSubview($0) }
        setConstatins()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstatins() {
        starButton.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).offset(8)
            make.width.height.equalTo(20)
        }
        
        checkButton.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.trailing.equalTo(self).offset(-8)
            make.width.height.equalTo(20)
        }
        label.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(starButton.snp.trailing).offset(15)
        }
    }
    
}
