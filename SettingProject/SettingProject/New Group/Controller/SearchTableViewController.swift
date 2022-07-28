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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "처음으로", style: .plain, target: self, action: #selector(resetButton))
    }
    
    @objc func resetButton(){
        //iOS13+ SceneDelegate 쓸 때 동작하는 코드
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "UINavi") as? UINavigationController
        
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
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

