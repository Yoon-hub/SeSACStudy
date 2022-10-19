//
//  ViewController.swift
//  MemoCompostialLayout
//
//  Created by 최윤제 on 2022/10/19.
//

import UIKit

struct Memo: Hashable {
    let title: String
    let content: String
    let fixed: Bool
}

class ViewController: UIViewController {
    
    let list: [Memo] = [
        Memo(title: "철수", content: "짱구는 못말려", fixed: false),
        Memo(title: "감자칩", content: "역시 근본은 프링글스", fixed: true),
        Memo(title: "chasing star", content: "𝘼𝙡𝙚𝙨𝙨𝙤 & 𝙈𝙖𝙧𝙨𝙝𝙢𝙚𝙡𝙡𝙤", fixed: false),
        Memo(title: "오늘은 수요일", content: "그냥 그렇다고", fixed: false)
    ]
    
    var cellResgistration: UICollectionView.CellRegistration<UICollectionViewListCell, Memo>!
    
    var dataSource: UICollectionViewDiffableDataSource<UICollectionViewListCell, Memo>!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureNavigation()
        configureCollectionView()
    }
    
    func configureNavigation() {
        navigationItem.title = String(list.count) + "개의 메모"
        navigationController?.navigationBar.prefersLargeTitles = true
        button.tintColor = UIColor(named: "tintColor")
        view.backgroundColor = UIColor(named: "background")
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.headerMode = .supplementary
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView.collectionViewLayout = layout
        
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <InteractiveHeader>(elementKind: UICollectionView.elementKindSectionHeader) {
            [unowned self] (headerView, elementKind, indexPath) in

            headerView.titleLabel.text = "메모"

        }
        
        cellResgistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            
            var content = cell.defaultContentConfiguration()
            content.text = itemIdentifier.title
            content.secondaryText = itemIdentifier.content
            cell.contentConfiguration = content
        }
    }
    

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let fixedMemoCount = list.filter { $0.fixed == true }.count

        return section == 0 ? fixedMemoCount : list.count - fixedMemoCount
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let fixedMemo = list.filter { $0.fixed == true }
        let nonFixedMemo = list.filter { $0.fixed == false }

        let item = indexPath.section == 0 ? fixedMemo[indexPath.item] : nonFixedMemo[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellResgistration, for: indexPath, item: item)

        return cell
    }


}




