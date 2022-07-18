//
//  TableViewController.swift
//  SettingProject
//
//  Created by 최윤제 on 2022/07/18.
//

import UIKit

class TableViewController: UITableViewController {
    let setting = ["전체설정", "개인 설정", "기타"]
    let allSetting = ["공지사항", "실험실", "버전 정보"]
    let personSetting = ["개인/보안", "알림", "채팅", "멀티프로필"]
    let etc = ["고객센터/도움말"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    //section 수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return setting.count
    }

    // cell 수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return allSetting.count
        } else if section == 1 {
            return personSetting.count
        } else if section == 2 {
            return etc.count
        } else {
            return 0
        }
    }
    
    // header 타이틀 설정
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return setting[section]
    }
    // cell 커스텀
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell")!
        if indexPath.section == 0 {
            cell.textLabel?.text = allSetting[indexPath.row]
        } else if indexPath.section == 1{
            cell.textLabel?.text = personSetting[indexPath.row]
        } else if indexPath.section == 2 {
            cell.textLabel?.text = etc[indexPath.row]
        }
        
        return cell
    }

}
