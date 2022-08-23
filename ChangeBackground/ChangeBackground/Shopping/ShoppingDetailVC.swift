//
//  ShoppingDetailVC.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/23.
//

import UIKit
import SnapKit
import SwiftUI


class ShoppingDetailVC: UIViewController {
    
    let smallView = UIView()
    let thingLabel = UILabel()
    let favoriteLabel = UILabel()
    let checkBoxLabel = UILabel()
    
    let stackView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.alignment = .center
    view.distribution = .fillEqually
    view.spacing = 2
    return view
}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        smallView.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(tapGestureClicked))
        view.addGestureRecognizer(tapGesture)
        smallView.layer.cornerRadius = 20
        
        configure()
        setConstatins()
    }
    
    func configure() {
        view.addSubview(smallView)
        
        [stackView].forEach {
            self.smallView.addSubview($0)
        }
        
        [thingLabel, favoriteLabel, checkBoxLabel].forEach {
              self.stackView.addArrangedSubview($0)
          }
       
    }
    
    func setConstatins() {
        smallView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.height.width.equalTo(view).multipliedBy(0.7)
        }
        stackView.snp.makeConstraints { make in
            make.center.equalTo(smallView)
        }
        
    }
    
    @objc func tapGestureClicked() {
        dismiss(animated: true)
    }
    
}
