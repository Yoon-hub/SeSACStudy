//
//  SubscirptExample.swift
//  SeSAC2Week18
//
//  Created by 최윤제 on 2022/11/03.
//

import Foundation

extension String {
    
    //jack >>> [1]  >>>> a
    
    //[여기안에 넣는다능]
    subscript(idx: Int) -> String? {
        
        guard (0..<self.count).contains(idx) else {
            return nil
        }
        
        let result = index(startIndex, offsetBy: idx)
        return String(self[result])
    }
    
}

extension Collection {
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


// let a = [Phone(), Phone()]
struct Phone {
    var numbers = ["1234", "6664", "3324", "4141"]
    
    subscript(idx: Int) -> String {
        get {
            return self.numbers[idx]
        }
        set {
            self.numbers[idx] = newValue
        }
    }
}
