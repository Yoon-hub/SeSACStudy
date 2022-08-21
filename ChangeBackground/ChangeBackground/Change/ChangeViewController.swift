//
//  ChageViewController.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/21.
//

import UIKit

import Kingfisher
import JGProgressHUD

class ChangeViewController: UIViewController{
    
    let changeView = ChangeView()
    var startPage = 1
    var totalPage = 0
    var imageList: [String] = []
    var selected: String = ""
    let hud = JGProgressHUD()
    
    var completionHandler: (() -> ())!
    
    
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
        changeView.collectionView.prefetchDataSource = self
        changeView.collectionView.allowsMultipleSelection = false
        changeView.searchBar.delegate = self
        
    
    }
    

    
    @objc
    func chageImage() {
        completionHandler()
        navigationController?.popViewController(animated: true)
        
    }
    
    func fetchImage(search: String) {
        hud.show(in: view)
        let query = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        ImageAPIManager.requestImage(search: query, page: startPage) { list, totalPage in
            self.totalPage = totalPage
            self.imageList.append(contentsOf: list)
            self.changeView.collectionView.reloadData()
            self.hud.dismiss(animated: true)
        }
    }

}

extension ChangeViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    
        for i in indexPaths{
            if i.item == imageList.count - 1 && startPage < totalPage{
                startPage += 1
                fetchImage(search: changeView.searchBar.text!)
            }
        }
            
    }
    
    
}


extension ChangeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChageCollectionViewCell.reusable, for: indexPath) as! ChageCollectionViewCell
        cell.imageView.kf.setImage(with: URL(string: imageList[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = changeView.collectionView.cellForItem(at: indexPath)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(chageImage))
        selected = imageList[indexPath.item]
        view.endEditing(true)
    }
    
    
    
}

extension ChangeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let search = searchBar.text, searchBar.text != ""{
            imageList.removeAll()
            startPage = 1
            changeView.collectionView.scrollsToTop
            fetchImage(search: search)
            startPage += 1
            fetchImage(search: search)
        } else {
            searchBar.placeholder = "검색결과를 입력해주세여"
        }
    }
}
