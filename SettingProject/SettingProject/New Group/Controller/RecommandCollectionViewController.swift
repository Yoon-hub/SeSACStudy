//
//  RecommandCollectionViewController.swift
//  SettingProject
//
//  Created by 최윤제 on 2022/07/20.
//

import UIKit
import Toast
import Kingfisher
/*
 TableView > CollectionView
 Row > Item
 heightForRowAt > FlowLayout (heightForItemAt이 없는 이유)
*/
class RecommandCollectionViewController: UICollectionViewController {

    //1. 값 전달 - 데이터를 받을 공간(프로퍼티) 생성
    var movieTitle : String?
    
    var imageURL = "https://search.pstatic.net/common/?src=http%3A%2F%2Fimgnews.naver.net%2Fimage%2F5353%2F2022%2F07%2F19%2F0000835650_001_20220719001802017.jpg&type=a340"
    
    override func viewDidLoad() {
        
        //3. 값 전달 - 프로퍼티 값을 뷰에 표현
        title = movieTitle == nil ? "데이터 없음" : movieTitle!
        
        let layout = UICollectionViewFlowLayout()
        let spacing : CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommandCollectionViewCell", for: indexPath) as? RecommandCollectionViewCell else {
            return UICollectionViewCell()
        }
                
        cell.posterImageView.backgroundColor = UIColor.orange
        let url = URL(string: imageURL)
        cell.posterImageView.kf.setImage(with: url)
        
        return cell
        
    }
    
    // cell 선택
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        view.makeToast("11")
    }


}
