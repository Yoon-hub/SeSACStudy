//
//  ShoppingViewController.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/22.
//

import UIKit

class ShoppingViewController: UIViewController {
    
    let shoppingView = ShoppingView()
    
    var shopList: [String] = []
    
    override func loadView() {
        self.view = shoppingView
        shoppingView.tableView.register(ShoppingTableViewCell.self, forCellReuseIdentifier: ShoppingTableViewCell.reusable)
        shoppingView.tableView.dataSource = self
        shoppingView.plusButton.addTarget(self, action: #selector(plusButtonClicked), for: .touchUpInside)
        shoppingView.tableView.rowHeight = 50
        
    }
    
    @objc
    func plusButtonClicked() {
        shopList.append(shoppingView.textField.text!)
        shoppingView.tableView.reloadData()
    }
    
}

extension ShoppingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingTableViewCell.reusable, for: indexPath) as? ShoppingTableViewCell else { return UITableViewCell() }
        
        cell.label.text = shopList[indexPath.row]
        
        return cell
    }
    
    
}
