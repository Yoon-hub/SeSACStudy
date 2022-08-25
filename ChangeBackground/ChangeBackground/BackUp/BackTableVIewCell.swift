//
//  BackTableVIewCell.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/25.
//

import UIKit

class BackTableViewCell: UITableViewCell {
    
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
