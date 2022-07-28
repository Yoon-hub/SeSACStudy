//
//  SelectViewController.swift
//  WebVeiwPorject
//
//  Created by 최윤제 on 2022/07/28.
//

import UIKit

struct Site{
    var title: String
    var image: String
    var url: String
}


class SelectViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var list: [Site] = [
        Site(title: "네이버", image: "naver", url: "https://www.naver.com/"),
        Site(title: "애플", image: "apple", url: "https://www.apple.com/"),
        Site(title: "유튜브", image: "youtube", url: "https://www.youtube.com/"),
        Site(title: "네이버", image: "naver", url: "https://www.naver.com/"),
        Site(title: "애플", image: "apple", url: "https://www.apple.com/")

        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width / 2.5
        layout.itemSize = CGSize(width: width, height: 155)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        collectionView.register(UINib(nibName: CollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.identifier)
    
    }
}

extension SelectViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
        cell.siteLabel.text = list[indexPath.row].title
        cell.siteImageView.image = UIImage(named: list[indexPath.row].image)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.url = list[indexPath.row].url
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}


