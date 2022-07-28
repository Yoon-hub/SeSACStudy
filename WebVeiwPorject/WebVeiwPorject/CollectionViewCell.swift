//
//  CollectionViewCell.swift
//  WebVeiwPorject
//
//  Created by 최윤제 on 2022/07/28.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var siteImageView: UIImageView!
    @IBOutlet weak var siteLabel: UILabel!
    
    static let identifier = "CollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
