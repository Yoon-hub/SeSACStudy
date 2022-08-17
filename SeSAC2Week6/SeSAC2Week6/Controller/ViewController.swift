//
//  ViewController.swift
//  SeSAC2Week6
//
//  Created by 최윤제 on 2022/08/08.
//

import UIKit

//import SwiftyJSON

/*
 1. html tag <> </> 기능 활용
 2. 문자열 대체
 */

/*
 TableView automaticDimension
 - 컨텐츠 양에 따라서 셀 높이가 자유롭게
 - 조건: numberOFLines 0
 - 조건: 테이블 뷰의 높이를
 - 조건: 레이아웃
 */

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var blogList: [String] = []
    var cafeList: [String] = []
    
    var isExpanded = false // false 2줄, true 0줄

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBlog()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        
    }
    
    private func searchBlog() {
        KakaoAPIManager.shared.callRequest(type: .blog, query: "고래밥") { json in
            
            for item in json["documents"].arrayValue {
                
                let value = item["contents"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                
                
                self.blogList.append(value)
            }
            self.searchCafe()
        }
    }
    
    func searchCafe() {
        KakaoAPIManager.shared.callRequest(type: .cafe, query: "고래밥") { json in
            for item in json["documents"].arrayValue {
                self.cafeList.append(item["contents"].stringValue)
            }
            print("BLog-----\n\(self.blogList)")
            print("Cafe-----\n\(self.cafeList)")
            self.tableView.reloadData()
        }
    }

    @IBAction func expandCell(_ sender: UIBarButtonItem) {
        isExpanded = !isExpanded
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return blogList.count
        } else {
            return cafeList.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kakaoCell", for: indexPath) as! kakaoCell
        cell.testLabel.numberOfLines = isExpanded ? 0 : 2
        cell.testLabel.text = indexPath.section == 0 ? blogList[indexPath.row] : cafeList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "블로구"
        } else {
            return "카페"
        }
    }
    
    
}

class kakaoCell: UITableViewCell {
    
    @IBOutlet weak var testLabel: UILabel!
    
}
