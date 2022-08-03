//
//  ImageSearchViewController.swift
//  SeSAC2LectureNetWorkBasic
//
//  Created by 최윤제 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class ImageSearchViewController: UIViewController {
    
    var imageList: [String] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        searchBar.delegate = self
        collectionView.layer.cornerRadius = 8
        fetchImage(text: "과자")
        let layout =  UICollectionViewFlowLayout()
        let spacing : CGFloat = 4
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = 25
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    
    }
    
    //fetch, request, callRequset, get ... > response에 따라 네이밍을 설정해주기도 함.
    //내일 > 페이지 네이션: offsetpagenation, cursorPagenation
    func fetchImage(text: String) {
        imageList.removeAll()
        let newtext = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! //인코딩
        let url = EndPoint.imageSearchURL + "query=\(newtext)&display=30&start=30" //왜 한글만 안되지?
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret" : APIKey.NAVER_SECRET]
        // header는 dictionarry구
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                
                for item in json["items"].arrayValue{
                    self.imageList.append(item["thumbnail"].stringValue)
                }
                
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }

    }
}
//MARK: - UICollecitonView DataSource
extension ImageSearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSearchCollectionViewCell", for: indexPath) as! ImageSearchCollectionViewCell
        cell.searchImageView.kf.setImage(with: URL(string: imageList[indexPath.row]))
        return cell
    }
    
    
}

//MARK: - SearchBar
extension ImageSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        print(1)
        fetchImage(text: searchBar.text!)
       
    }
}
