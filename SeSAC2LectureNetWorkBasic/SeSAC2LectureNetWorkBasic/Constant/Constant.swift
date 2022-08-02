//
//  Constatns.swift
//  SeSAC2LectureNetWorkBasic
//
//  Created by 최윤제 on 2022/08/01.
//

import Foundation

//enum StoryboardName: String{
//    case Main
//    case Search
//    case Setting
//}

//struct StoryboardName {
//
//    //접근제어를 통해 초기화 방지
//    private init(){
//
//    }
//
//    static let main = "Main"
//    static let search = "Search"
//    static let setting = "Setting"
//}

/*
1. struct type property vs enum type property => 인스턴스 생성 방지 가능
2. enum case vs static = > case는 같은 rawValue를 가질 수 없다 능
 */



enum StoryboardName { // 공통된 상수 관리에는 최고다!
    static let main = "Main"
    static let search = "Search"
    static let setting = "Setting"
}

enum FontName {
    static let title = "SanFransisco"
    static let body = "SanFransisco"

}

