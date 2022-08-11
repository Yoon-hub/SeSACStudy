//
//  CardCollectionViewCell.swift
//  SeSAC2Week6
//
//  Created by 최윤제 on 2022/08/09.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: CardView!
    
    // 변경되지 않는 UI
    // 약간 viewdidLoad같은 느낌이네
    override func awakeFromNib() {
        super.awakeFromNib()
        print("CardCollectionViewCell", #function)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cardView.contentLabel.text = "A"
    }
    
    func setupUI() {
        cardView.backgroundColor = .clear
        cardView.imageView.backgroundColor = .lightGray
        cardView.imageView.layer.cornerRadius = 10
        cardView.likeButton.tintColor = .systemPink
    }
    

}
