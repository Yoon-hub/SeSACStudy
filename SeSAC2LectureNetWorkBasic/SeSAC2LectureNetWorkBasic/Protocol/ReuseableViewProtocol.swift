//
//  ReuseableViewProtocol.swift
//  SeSAC2LectureNetWorkBasic
//
//  Created by 최윤제 on 2022/08/01.
//

import UIKit

protocol ReuseableViewProtocol {
    static var reuseIdentifier: String { get }
}

extension UIViewController: ReuseableViewProtocol{ //extension 저장 프로퍼티 불가능
    static var reuseIdentifier: String {  // 연산 프로퍼티 get만 사용한다면 get 생략가능
        return String(describing: self)
    }
    
}

extension UITableViewCell: ReuseableViewProtocol{
    static var reuseIdentifier: String {  // 연산 프로퍼티 get만 사용한다면 get 생략가능
        return String(describing: self)
    }
}
