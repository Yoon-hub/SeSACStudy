//
//  SeSACButton.swift
//  SeSAC2Week6
//
//  Created by 최윤제 on 2022/08/09.
//
/*
 Swift Attribute(속성)
 @IBInspectable, @IBDesignable, @objc, @escaping, @available, @discardableResult
 */

import UIKit

@IBDesignable   // 스토리 보드상에 변경 된걸 확인 가능
class SeSACButton: UIButton {

    @IBInspectable // 인스팩터 영역에 등록
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
}
