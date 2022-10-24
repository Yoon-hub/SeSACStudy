//
//  DiffableViewModel.swift
//  SeSACWeek16
//
//  Created by 최윤제 on 2022/10/20.
//

import Foundation

class DiffableViewModel {
    
    var photoList: CObservable<SearchPhoto> = CObservable(SearchPhoto(total: 0, totalPages: 0, results: []))
    
    func requestSearchPhoto(query: String) {
        APIService.serachPhoto(query: query) { photo, statusCode, error in
            
            guard let photo = photo else {return}
            self.photoList.value = photo
            
        }
    }
}
