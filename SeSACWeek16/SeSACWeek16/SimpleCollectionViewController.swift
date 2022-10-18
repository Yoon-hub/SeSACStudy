//
//  SimpleCollectionCollectionViewController.swift
//  SeSACWeek16
//
//  Created by 최윤제 on 2022/10/18.
//

import UIKit

struct User {
    
    let name: String
    let age: Int
    
}

class SimpleCollectionViewController: UICollectionViewController {
    
    //var list = ["닭곰탕", "삼계탕", "들기름김", "삼분카레", "콘소메 치킨"]
    //cellForItemAt 전에 생성되어야 한다.
    
    var list = [
        User(name: "뽀로로", age: 3),
        User(name: "에디", age: 13),
        User(name: "해리포터", age: 33),
        User(name: "도라에몽", age: 5)
    ]
    
    var cellResgistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //14+ 컬렉션뷰를 테이블뷰 스타일처럼 사용가능(List Coniguration)
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false // 구분선 지움
        configuration.backgroundColor = .brown
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView.collectionViewLayout = layout
        
        cellResgistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in  //cell 그려질때 데이터 담당을 여기서, 하나의 cell을 담당
            
            var content = UIListContentConfiguration.valueCell()     // cell.defaultContentConfiguration()
            
            content.text = itemIdentifier.name  // itemIdentifier == item
            content.prefersSideBySideTextAndSecondaryText = false
            content.textToSecondaryTextVerticalPadding = 20
            content.textProperties.color = .red
            
            content.secondaryText = String(itemIdentifier.age)
            
            //content.image = indexPath.item < 3 ? UIImage(systemName: "person.fill") : UIImage(systemName: "star")
            content.image = itemIdentifier.age < 8 ? UIImage(systemName: "person.fill") : UIImage(systemName: "star")
            content.imageProperties.tintColor = .blue
            
            cell.contentConfiguration = content
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = list[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellResgistration, for: indexPath, item: item)
        
        return cell
    }


}
