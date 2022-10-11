//
//  PersonViewModel.swift
//  SeSAC2Week9
//
//  Created by 최윤제 on 2022/08/31.
//

import Foundation

class PersonViewModel {
    
    var list: Observable<Person> = Observable(Person(page: 0, totalPages: 0, totalResults: 0, results: []))
    
    var numberOfRowsInSection: Int {
        return list.value.results.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Result {
        return list.value.results[indexPath.row]
    }
    
    func fetchPerson(query: String) {
        //네트워크 통신도 비지니스 로직
        PersonAPIManager.requestPerson(query: query) { person, error in
            dump(person!)
            self.list.value = person!
           
        }
    }
    
}
