//
//  NewsViewController.swift
//  SeSACWeek16
//
//  Created by 최윤제 on 2022/10/20.
//

import UIKit

import RxSwift
import RxCocoa

class NewsViewController: UIViewController {
    
    var viewModel = NewsViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var disposeBag = DisposeBag()
    
    var dataSource: UICollectionViewDiffableDataSource<Int, News.NewsItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureDataSource()
        bindData()
        //configureViews()

    }
    //Relay는 Subject보다 Rxcoca에 더 특화됨
    //bind는
    
    private func bindData() {
        
        viewModel.pageNumber // 순환참조 방지
            .withUnretained(self)
            .bind { vc, value in
                print("bind == \(value)")
                vc.numberTextField.text = value
            }
            .disposed(by: disposeBag)
        
        viewModel.sample
            .withUnretained(self)
            .bind { vc, value in
                var snapshot = NSDiffableDataSourceSnapshot<Int, News.NewsItem>()
                snapshot.appendSections([0])
                snapshot.appendItems(value)
                vc.dataSource.apply(snapshot, animatingDifferences: false)
        }
        .disposed(by: disposeBag)
        
        loadButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.viewModel.loadSample()
            }
            .disposed(by: disposeBag)
        
        resetButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.viewModel.resetSample()
            }
            .disposed(by: disposeBag)
    }
    
//    private func configureViews() {
//
//        numberTextField.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)
//        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
//        loadButton.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
//    }
//
//    @objc func numberTextFieldChanged() {
//        guard let text = numberTextField.text else { return } // 옵셔널 처리도 뷰모델에서 해줘도 괜찮다
//        viewModel.changePageNumberFormat(text: text)
//    }
//
//    @objc func resetButtonTapped() {
//        viewModel.resetSample()
//        print(#function)
//    }
//
//    @objc func loadButtonTapped() {
//        viewModel.loadSample()
//    }

}

extension NewsViewController {
    
    func configureHierachy() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .lightGray
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, News.NewsItem> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            content.secondaryText = itemIdentifier.body
            
            cell.contentConfiguration = content
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    
        
    }
    
    func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
}
