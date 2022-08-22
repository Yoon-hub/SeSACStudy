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
    
    var tasks: Results<UserShoppingList>!
    
    override func loadView() {
        self.view = shoppingView
        
        tasks = localRealm.objects(UserShoppingList.self)
    
        shoppingView.tableView.register(ShoppingTableViewCell.self, forCellReuseIdentifier: ShoppingTableViewCell.reusable)
        shoppingView.tableView.dataSource = self
        shoppingView.plusButton.addTarget(self, action: #selector(plusButtonClicked), for: .touchUpInside)
        shoppingView.tableView.rowHeight = 50
        
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
        
        return cell
    }
    
    
}
