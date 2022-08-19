//
//  BaseView.swift
//  CodeNeflix
//
//  Created by 최윤제 on 2022/08/19.
//
import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() { }
    func setConstaints() { }
    
}
