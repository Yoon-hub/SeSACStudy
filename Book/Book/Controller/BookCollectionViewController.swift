//
//  BookCollectionViewController.swift
//  Book
//
//  Created by 최윤제 on 2022/07/20.
//

import UIKit

private let reuseIdentifier = "Cell"

class BookCollectionViewController: UICollectionViewController {
    
    var book = BookInfo()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutDesgin()
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButton) )
        navigationItem.rightBarButtonItem?.tintColor = .black

    }
    @objc func searchButton(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let navi = UINavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .fullScreen
        
        self.present(navi, animated: true)
        
    }
     
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return book.bookList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
        cell.configuration(data: book.bookList[indexPath.row])
        cell.backgroundColor = book.color[indexPath.row % 4]
        
        return cell
    }
    	
    func layoutDesgin(){
        let layout =  UICollectionViewFlowLayout()
        let spacing : CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }



    
}
