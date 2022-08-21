//
//  ChageViewController.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/21.
//

import UIKit

class ChangeViewController: UIViewController, UISearchBarDelegate {
    
    let changeView = ChangeView()
    
    var imageList: [String] = []
    
    override func loadView() {
        super.loadView()
        self.view = changeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeView.backgroundColor = .white
        
        changeView.collectionView.delegate = self
        changeView.collectionView.dataSource = self
        changeView.collectionView.register(ChageCollectionViewCell.self, forCellWithReuseIdentifier: ChageCollectionViewCell.reusable)
        
        changeView.searchBar.delegate = self
    }
}


extension ChangeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChageCollectionViewCell.reusable, for: indexPath) as! ChageCollectionViewCell
        cell.imageView.image = UIImage(named: "bg")
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let search = searchBar.text, searchBar.text != ""{
            ImageAPIManager.requestImage(search: search, page: 1)
        } else {
            searchBar.placeholder = "검색결과를 입력해주세여"
        }
    }
    
    
}

