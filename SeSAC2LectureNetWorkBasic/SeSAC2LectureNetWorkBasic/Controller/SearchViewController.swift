//
//  SearchViewController.swift
//  SeSAC2LectureNetWorkBasic
//
//  Created by 최윤제 on 2022/07/27.
//

import UIKit

import Alamofire
import SwiftyJSON
import JGProgressHUD
import RealmSwift
    
/*
 Swift Protocol
 - Delegate
 - Datasource
 
 1. 왼팔 / 오른팔
\
 
 */
/*
 
 각 json value -> list -> 테이블뷰 갱신
 서버의 응답이 몇개인 지 모를 경우에는?
 
 pagenation
 1. will display cell: 권장 x, 보여줄 예정
 2. Scrollview의 scroll 시점 활용, 가장 많이 사용
 3. Protocol 활용 DataSourcePrefetching
 */

extension UIViewController {
    func setBackground(){
        view.backgroundColor = .red
    }
}


class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

 
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    //BoxOffice 배열
    var list: [BoxOfficeModel] = []
    //ProgressView
    let hud = JGProgressHUD()
    
    let localRealm = try! Realm()
    
    var tasks: Results<BoxOfficeInfo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchTableView.backgroundColor = .clear
        //연결고리 작업: 테이블뷰가 해야 할 역할 > 뷰 컨트롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        // Do any additional setup after loading the view.
        //테에블뷰가 사용할 테이블뷰 셀(XIB) 등록
        //XIB : xml inerface builder <= Nib - 예전이름
        searchTableView.register( UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        
        tasks = localRealm.objects(BoxOfficeInfo.self).filter("date == '\(today())'")
        if tasks.count == 0 {
            print("API 통신함")
            requestBoxOffice(text: today())
        } else {
            print("Realm에서 꺼내옴")
            for i in tasks {
                list.append(BoxOfficeModel(movieTitle: i.movieTitle, releaseData: i.releaseData, totalCount: i.totalCount))
                searchTableView.reloadData()
            }
        }
        //requestBoxOffice(text: today())
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
        
        searchTableView.rowHeight = 80
        
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        
        
    }
    
    func today() -> String {
        let format = DateFormatter()
        format.locale = Locale(identifier: "ko_KR")
        format.timeZone = TimeZone(abbreviation: "KST")
        
        format.dateFormat = "yyyyMMdd"
        let yesterday = Date().addingTimeInterval(86400 * -1)
        let result = format.string(from: yesterday)
        
        return result
    }
    
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
    
    func configureLable() {
        
    }
    
    func requestBoxOffice(text: String){
        
        hud.show(in: view)
        list.removeAll()
        
        let url = "\(EndPoint.boxofficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(text)"
        
        //Serialization <-> Desrialization
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let movieNm = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    
                    self.list.append(BoxOfficeModel(movieTitle: movieNm, releaseData: openDt, totalCount: audiAcc))
                    
                    let task = BoxOfficeInfo(date: self.today(), movieTitle: movieNm, releaseData: openDt, totalCount: audiAcc)// => Record 한줄 추가
                    try! self.localRealm.write {
                        self.localRealm.add(task) //Create
                    }

                }
                
            
                //list배열에 데이터 추가
                
                self.searchTableView.reloadData()
                self.hud.dismiss(animated: true)
            case .failure(let error):
                print(error)
                self.hud.dismiss(animated: true)
                //시뮬레이터 실패 테스트 >
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else{
            return UITableViewCell()
        }
        
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = list[indexPath.row].movieTitle
        cell.etcInfo.text = "개봉일자: \(list[indexPath.row].releaseData)\n 총관객수: \(list[indexPath.row].totalCount)"
        
        return cell
        
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestBoxOffice(text: searchBar.text!) // 옵셔널 바인딩, 8글자, 숫자, 날짜로 변경 시 유요한 형태의 값인 자 등
    }
}

