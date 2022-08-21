//
//  ChageViewController.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/21.
//

import UIKit

class ChangeViewController: UIViewController {
    
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
        
    }
}

extension ChangeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChageCollectionViewCell.reusable, for: indexPath) as! ChageCollectionViewCell
        cell.imageView.image = UIImage(named: "bg")
        return cell
    }
    
    
}
