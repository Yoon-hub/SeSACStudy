//
//  ChageView.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/21.
//

import UIKit
import SnapKit

class ChangeView: BaseView {
    let searchBar = UISearchBar()
    
    
    let collectionView: UICollectionView = {
        let layout =  UICollectionViewFlowLayout()
        let spacing : CGFloat = 4
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: (width / 3) - 1, height: (width / 3) - 1)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
       
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    
    override func configure() {
        [searchBar, collectionView].forEach { self.addSubview($0) }
    }
    
    override func setContraints() {
        
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.trailing.leading.bottom.equalTo(self)
        }
    }
    
}
