//
//  DiffableViewModel.swift
//  SeSACWeek16
//
//  Created by 최윤제 on 2022/10/20.
//

import Foundation

import RxSwift

enum SearchError: Error {
    case noPhoto
    case serverError
}

class DiffableViewModel {
    
    //var photoList: CObservable<SearchPhoto> = CObservable(SearchPhoto(total: 0, totalPages: 0, results: []))
    var photoList = PublishSubject<SearchPhoto>()
    
    func requestSearchPhoto(query: String) {
        APIService.serachPhoto(query: query) { [weak self] photo, statusCode, error in
            
            guard let statusCode = statusCode, statusCode == 200 else {
                self?.photoList.onError(SearchError.serverError)  // 구독이 종료 된다
                return
            }
            
            guard let photo = photo else {
                self?.photoList.onError(SearchError.noPhoto)
                return
            }
            self?.photoList.onNext(photo)
            
        }
    }
}
