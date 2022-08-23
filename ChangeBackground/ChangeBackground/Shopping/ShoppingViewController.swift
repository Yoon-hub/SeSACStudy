//
//  ShoppingViewController.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/22.
//

import UIKit
import RealmSwift

class ShoppingViewController: UIViewController {
    
    let shoppingView = ShoppingView()
    let localRealm = try! Realm()
    
    var tasks: Results<UserShoppingList>! {
        didSet {
            shoppingView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = shoppingView
        
        fetchRealm()
    
        shoppingView.tableView.register(ShoppingTableViewCell.self, forCellReuseIdentifier: ShoppingTableViewCell.reusable)
        shoppingView.tableView.dataSource = self
        shoppingView.plusButton.addTarget(self, action: #selector(plusButtonClicked), for: .touchUpInside)
        shoppingView.tableView.rowHeight = 50
        
    }
    
    func fetchRealm() {
        tasks = localRealm.objects(UserShoppingList.self)
    }
    
    @objc
    func plusButtonClicked() {
        let task = UserShoppingList(shopThing: shoppingView.textField.text!)
        
        try! localRealm.write {
            localRealm.add(task) //Create
        }

        shoppingView.tableView.reloadData()
        
    }
    
}

extension ShoppingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingTableViewCell.reusable, for: indexPath) as? ShoppingTableViewCell else { return UITableViewCell() }
        
        cell.label.text = tasks[indexPath.row].shopThing
        
        let starButtonimage = tasks[indexPath.row].favortie ? "star.fill" : "star"
        cell.starButton.setImage(UIImage(systemName: starButtonimage), for: .normal)
        
        cell.starButton.tag = indexPath.row
        cell.starButton.addTarget(self, action: #selector(starButtonClicekd(_:)), for: .touchUpInside)
        
        let checkButtonimage = tasks[indexPath.row].checkBox ? "checkmark.square.fill" : "checkmark.square"
        cell.checkButton.setImage(UIImage(systemName: checkButtonimage), for: .normal)
        
        cell.checkButton.tag = indexPath.row
        cell.checkButton.addTarget(self, action: #selector(checkButtonClicekd(_:)), for: .touchUpInside)

        
        return cell
    }
    
    @objc func starButtonClicekd(_ startButton: UIButton) {
        
        try! localRealm.write {
            tasks[startButton.tag].favortie = !tasks[startButton.tag].favortie
            self.fetchRealm()
        }
    }
    
    @objc func checkButtonClicekd(_ checkButton: UIButton) {
        
        try! localRealm.write {
            tasks[checkButton.tag].checkBox = !tasks[checkButton.tag].checkBox
            self.fetchRealm()
        }
    }


    
}
