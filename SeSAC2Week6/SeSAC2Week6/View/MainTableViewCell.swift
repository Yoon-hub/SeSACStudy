//
//  MainTableViewCell.swift
//  SeSAC2Week6
//
//  Created by 최윤제 on 2022/08/09.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    // CollectionView Delegate, DataSource를 MainTableVIewController에 연결
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("MainTableViewCell", #function)
        setupUI()
    }
    
    func setupUI() {
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.text = "넷플릭스 인기 콘텐츠"
        titleLabel.backgroundColor = .clear
        
        contentCollectionView.backgroundColor = .gray
        contentCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 180)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        return layout
    }

}
