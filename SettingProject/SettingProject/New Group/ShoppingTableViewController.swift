//
//  ShoppingTableViewController.swift
//  SettingProject
//
//  Created by 최윤제 on 2022/07/19.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var shoppingList = ["그립톡 구매하기", "사이다 구매", "아이패드 거치대 구매", "고래밥"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 60
        searchTextField.placeholder = "무엇을 구매하실 건가요?"
        addButton.layer.cornerRadius = 10
    }
    // cell수 결정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    // cell 커스텀
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCollectionViewCell", for: indexPath) as! ShoppingTableViewCell
        
        
        cell.shoppingLabel.text = shoppingList[indexPath.row]
        cell.checkBoxImageView.image = indexPath.row == 0 ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        indexPath.row == 1 ? cell.starButton.setImage(UIImage(systemName: "star"), for: .normal) : cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.backgroundColor = .systemGray6
        
        return cell
        
        
    }
 
    @IBAction func addButtonClicked(_ sender: UIButton) {
        appendList()
    }
    
    @IBAction func doneTextField(_ sender: UITextField) {
        appendList()
    }
    
    //편집 가능하게 cell 활성화
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    //우측 스와이프 디폴트 기능: commit editingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            //배열 삭제 후 테이블 뷰 갱신
            shoppingList.remove(at:indexPath.row)
            tableView.reloadData()
        }
    }
    

    
    func appendList(){
        shoppingList.append(searchTextField.text!)
        tableView.endEditing(true)
        searchTextField.text = nil
        tableView.reloadData()
    }

}
    
