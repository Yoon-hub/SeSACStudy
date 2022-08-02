//
//  BeerTableViewController.swift
//  SeSAC2LectureNetWorkBasic
//
//  Created by 최윤제 on 2022/08/02.
//

import UIKit

import Alamofire
import SwiftyJSON

class BeerTableViewController: UITableViewController {
    
    var beer: [BoxOfficeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        tableView.rowHeight = 80

        requestBeer()
    }

    // MARK: - Table view data source
    
    func requestBeer() {
        let url = "https://api.punkapi.com/v2/beers"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for item in json.arrayValue{
                    let beerName = item["name"].stringValue
                    let description = item["description"].stringValue
                    let imageUrl = item["image_url"].stringValue
                    
                    self.beer.append(BoxOfficeModel(movieTitle: beerName, releaseData: description, totalCount: imageUrl))
                }
                
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beer.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as! ListTableViewCell
        let urlImage = URL(string: beer[indexPath.row].totalCount)
        cell.posterimageView.kf.setImage(with: urlImage)
        cell.titleLabel.text = beer[indexPath.row].movieTitle
        cell.etcInfo.text = beer[indexPath.row].releaseData
        
        return cell
    }
    

}
