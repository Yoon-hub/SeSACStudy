//
//  TFReusableIdentifier.swift
//  TMDBFramework
//
//  Created by 최윤제 on 2022/08/16.
//

import UIKit

public protocol ReuseableViewProtocol {
    static var resuableIdentifer : String { get }
}

extension UIViewController: ReuseableViewProtocol {
    public static var resuableIdentifer: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReuseableViewProtocol {
    public static var resuableIdentifer: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseableViewProtocol {
    public static var resuableIdentifer: String {
        return String(describing: self)
    }
}
