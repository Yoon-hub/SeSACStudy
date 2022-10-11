//
//  HomeTableViewCell.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/23.
//

import UIKit
import SnapKit

class HomeTableViewCell: UITableViewCell {
    
    let titleLable: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 16)
        return view
    }()
    
    let dateLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    let textLable: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    let image: UIImageView = {
       let view = UIImageView()
        view.backgroundColor = .blue
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
   
        [titleLable, dateLabel, textLable, image].forEach{ self.addSubview($0) }
        
        titleLable.snp.makeConstraints { make in
            make.top.leading.equalTo(self).offset(4)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(4)
            make.leading.equalTo(self).offset(4)
        }
        textLable.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
        }
        
        image.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.trailing.equalTo(self).offset(-4)
            make.height.equalTo(self).multipliedBy(0.7)
            make.width.equalTo(70)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
