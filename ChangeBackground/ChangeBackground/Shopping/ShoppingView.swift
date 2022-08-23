//
//  ShoppingView.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/22.
//

import UIKit

import SnapKit

class ShoppingView: BaseView {
    
    let textField: UITextField = {
       let view = UITextField()
        view.borderStyle = .roundedRect
        view.placeholder = "추가 하고싶은 항목을 작성 하세용"
        return view
    }()
    
    let plusButton: UIButton = {
       let view = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 50)
        view.setImage(UIImage(systemName: "plus",withConfiguration: config), for: .normal)
        view.tintColor = .lightGray
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    override func configure() {
        [textField, plusButton, tableView].forEach { self.addSubview($0) }
    
    }
    
    override func setContraints() {
        self.backgroundColor = .white
        textField.snp.makeConstraints { make in
            make.top.trailing.leading.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        plusButton.snp.makeConstraints { make in
            make.centerY.equalTo(textField)
            make.trailing.equalTo(textField.snp.trailing).offset(-10)
            make.height.width.equalTo(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    
        
    }
}
