//
//  SeSACReuseable.swift
//  SeSAC2UIFramework
//
//  Created by 최윤제 on 2022/08/16.
//

import UIKit

//Reusable
//open은 class에서만 사용이 가능하다 왜? 상속을 가능하게 하기 위해서 만든 것 이라
public protocol ReusableViewProtocol {
    static var reuseIdentifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension UITableViewCell: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
