//
//  BucketlistTableViewController.swift
//  SettingProject
//
//  Created by 최윤제 on 2022/07/19.
//

import UIKit

class BucketlistTableViewController: UITableViewController {
    
    var list = ["범죄도시2", "탑건", "토르"]

    @IBOutlet weak var userTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list.append("마녀2")
        list.append("놈놈놈")
        
    }
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        list.append(sender.text!)
        
        //중요
        tableView.reloadData()
        
       // tableView.reloadSections(<#T##sections: IndexSet##IndexSet#>, with: <#T##UITableView.RowAnimation#>) section 하나만 갱신
        //tableView.reloadRows(at: [IndexPath(row: 1, section: 1)], with: <#T##UITableView.RowAnimation#>) //cell 하나만 갱신
    }
    //section수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //cell수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    //cell 커스텀
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BucketlistTableViewCell", for: indexPath) as! BucketlistTableViewCell // as? 타입 캐스팅
        
        cell.bucketListLabel.text = list[indexPath.row]
        cell.bucketListLabel.font = .boldSystemFont(ofSize: 18)
        
        return cell
        
    }
    
    //편집 가능하게 cell 활성화
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    //우측 스와이프 디폴트 기능: commit editingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            //배열 삭제 후 테이블 뷰 갱신
            list.remove(at:indexPath.row)
            tableView.reloadData()
        }
    }
    

}

