//
//  SearchTableViewController.swift
//  SettingProject
//
//  Created by 최윤제 on 2022/07/20.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    var moiveList = MovieInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 125

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moiveList.movie.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.configureCell(data: moiveList.movie[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
    }

}
