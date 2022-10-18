//
//  ViewController.swift
//  SeSACWeek16
//
//  Created by 최윤제 on 2022/10/18.
//

import UIKit

class SimpleTableViewController: UITableViewController {
    
    let list = ["슈비버거", "프랭크", "자갈치", "고래밥"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()   // class라 프로퍼티를 변경을 해도 let 이여도 된다.
        
        var content = cell.defaultContentConfiguration()  // stuct라 var 여도 된다.
        content.text = list[indexPath.row] // textLabel
        content.secondaryText = "안녕하세요"
        
        cell.contentConfiguration = content
        
        return cell
        
    }

}

