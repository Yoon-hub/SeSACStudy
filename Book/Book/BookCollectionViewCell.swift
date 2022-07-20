//
//  BookCollectionViewCell.swift
//  Book
//
//  Created by 최윤제 on 2022/07/20.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func configuration(data : Book){
        
        self.layer.cornerRadius = 25
        bookTitleLabel.font = .boldSystemFont(ofSize: 18)
        bookTitleLabel.text = data.bookTitle
        bookImageView.image = UIImage(named: data.bookImage)
        ratingLabel.text = String(data.bookrating)
    }
    
}
