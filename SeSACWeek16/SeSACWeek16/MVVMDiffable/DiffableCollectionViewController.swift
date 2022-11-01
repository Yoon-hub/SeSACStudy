//
//  DiffableCollectionViewController.swift
//  SeSACWeek16
//
//  Created by 최윤제 on 2022/10/19.
//

import UIKit

import RxSwift
import RxCocoa

//Relay -> Next 이벤트만 방출 하는데 Next를 Accept라고 부른다
class DiffableCollectionViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var disposeBag = DisposeBag()
    
    var viewModel = DiffableViewModel()
    
    
   // private var cellRegisteration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
    
    //Int는 Section, String은 들어갈 데이터
    private var dataSource: UICollectionViewDiffableDataSource<Int, SearchResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // APIService.serachPhoto(query: "apple")

        collectionView.collectionViewLayout = creatLayout()
        configureDataSource()
        collectionView.delegate = self
       // searchBar.delegate = self
        
        
        viewModel.photoList
            .withUnretained(self)
            .subscribe(onNext: { vc, photo in
                //Initial
                var snapshot = NSDiffableDataSourceSnapshot<Int, SearchResult>()
                snapshot.appendSections([0])
                snapshot.appendItems(photo.results)
                vc.dataSource.apply(snapshot)
            }, onError: { error in
                print("====error: \(error)")
            }, onCompleted: {
                print("====: completed")
            }, onDisposed: {
                print("====: disposed")
            })
            .disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .withUnretained(self)
            .subscribe { vc, value in
                print(value)
                vc.viewModel.requestSearchPhoto(query: value)
            }
            .disposed(by: disposeBag)
    }
}
    

extension DiffableCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        guard let item = dataSource.itemIdentifier(for: indexPath) else {return }
//
//        let alert = UIAlertController(title: item, message: "클릭!", preferredStyle: .alert)
//        let ok = UIAlertAction(title: "확인", style: .cancel)
//        alert.addAction(ok)
//        present(alert, animated: true)
    }
    
}

extension DiffableCollectionViewController {
    
    private func creatLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func configureDataSource() {
        
        let cellRegisteration = UICollectionView.CellRegistration<UICollectionViewCell, SearchResult>(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = String(itemIdentifier.likes)
            print(itemIdentifier.urls.thumb)
            // String > URL > Data > IMage
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.thumb)!
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content
                }
            }
            
            //content.secondaryText = "\(itemIdentifier.count)"
       
            
            var background = UIBackgroundConfiguration.listPlainCell()
            background.strokeWidth = 2
            background.strokeColor = .brown
            cell.backgroundConfiguration = background
        })
        
        //numberOfItemsInSection, cellFortItemAt 을 대체하는 메서드
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier)
            return cell
        })
        

    }
}

extension DiffableCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.requestSearchPhoto(query: searchBar.text!)
    }
}
