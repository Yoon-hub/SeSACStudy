//
//  TableViewController.swift
//  SettingProject
//
//  Created by 최윤제 on 2022/07/18.
//

import UIKit

//CaseIterable: 프로토콜, 배열처럼 열거형을 활용할 수 있는 특성
enum SettingOptions: Int, CaseIterable {
    case total, personal, others // 섹션
    
    var setionTitle: String {
        switch self {
        case .total:
            return "전체 설정"
        case .personal:
            return "개인 설정"
        case .others:
            return "기타"
        }
    }
    
    var rowTitle: [String]{
        switch self {
        case .total:
            return ["공지사항", "실험실", "버전 정보"]
        case .personal:
            return ["개인/보안", "알림", "채팅", "멀티프로필"]
        case .others:
            return ["고객센터/도움말"]
        }
    }
}

class TableViewController: UITableViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    //section 수
    override func numberOfSections(in tableView: UITableView) -> Int {
        //return setting.count
        return SettingOptions.allCases.count
    }

    // cell 수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return SettingOptions.allCases[section].rowTitle.count
    }
    
    // header 타이틀 설정
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingOptions.allCases[section].setionTitle
    }
    // cell 커스텀
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell")!
        
        cell.textLabel?.text = SettingOptions.allCases[indexPath.section].rowTitle[indexPath.row]
        return cell
    }

}
