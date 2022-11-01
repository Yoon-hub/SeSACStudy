//
//  NewsViewModel.swift
//  SeSACWeek16
//
//  Created by 최윤제 on 2022/10/20.
//

import Foundation

import RxSwift
import RxCocoa

class NewsViewModel {
    
    //var pageNumber: CObservable<String> = CObservable("3000")
    var pageNumber = BehaviorSubject<String>(value: "3,000")
    
    //var sample: CObservable<[News.NewsItem]> = CObservable(News.items)
    //var sample = BehaviorSubject<[News.NewsItem]>(value: News.items)
    var sample = BehaviorRelay(value: News.items) // relay 실패하지 않는상황 오직 next만 방출 하는 상황
    
    func changePageNumberFormat(text: String) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let text = text.replacingOccurrences(of: ",", with: "")
        guard let number = Int(text) else { return }
        let result = numberFormatter.string(for: number)!
        pageNumber.onNext(result)
        
    }
    
    func resetSample() {
        //sample.onNext([])
        sample.accept([]) // relay라서 변경됨
        print(#function)
    }
    
    func loadSample() {
        //sample.value = News.items
        //sample.onNext(News.items)
        sample.accept(News.items)
    }
}
