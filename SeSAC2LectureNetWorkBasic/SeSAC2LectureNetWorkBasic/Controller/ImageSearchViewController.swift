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
    //네트워크 요청할 시작 페이지 넘버
    var startPage = 1
    var totoal = 0
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        collectionView.prefetchDataSource = self //페이지네이션
        
        collectionView.layer.cornerRadius = 8
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
        ImageSearchAPIManager.shared.fetchImageDate(text: text, startPage: startPage) { total, list in
            self.totoal = total
            self.imageList.append(contentsOf: list)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
           
        }

    }
}

//페이지네이션 방법3.
//용량이 큰 이미지를 다운받아 셀에 보여주려고 하는 경우에 효과적.
//셀이 화면에 보이기 전에 미리 필요한 리소스를 다운받을 수도 있고, 필요하지 않다면 데이터를 취소할 수도 있음.
//iOS10 이상, 스크롤 성능 향상됨.
extension ImageSearchViewController: UICollectionViewDataSourcePrefetching {
    
    //셀이 화면에 보이기 직전에 필요한 리로스를 미리 다운 받는 기능
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("====\(indexPaths)")
        
        for indexPath in indexPaths {
            if imageList.count - 2 == indexPath.item && imageList.count < totoal{
                startPage += 30
                fetchImage(text: searchBar.text!)
            }
        }
        
        
    }
    
    //취소: 직접 취소하는 기능으 구현
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("===취소: \(indexPaths)")
    }
    
}





//MARK: - UICollecitonView DataSource
extension ImageSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSearchCollectionViewCell", for: indexPath) as! ImageSearchCollectionViewCell
        cell.searchImageView.kf.setImage(with: URL(string: imageList[indexPath.row]))
        return cell
    }
  
    //pagenation 첫번 쨰 방법 권장 x
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//    }
//
    
//    //페이지네이션 방법2. UIScrollViewDelegateProtocol.
//    //테이블뷰/컬렉션 뷰 상속 받고있어서, 스크롤뷰 프로토콜을 사용할 수 있음
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset) //사용자가 얼마나 내려왔는지 확인
//    }
    
    
}

//MARK: - SearchBar
extension ImageSearchViewController: UISearchBarDelegate {
    
    //검색 버튼 클릭 시 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text {
            imageList.removeAll()
            startPage = 1
            
            collectionView.scrollsToTop
            fetchImage(text: text)
        }
        
    }
    //최소 버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        imageList.removeAll()
        collectionView.reloadData()
        startPage = 1
        searchBar.text = ""
        
        searchBar.setShowsCancelButton(false, animated: true)
    }
    //서치바에 커서가 깜빡이기 시작할 때 실행
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}
