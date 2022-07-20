//
//  BookInfo.swift
//  Book
//
//  Created by 최윤제 on 2022/07/20.
//

import Foundation
import UIKit

struct BookInfo{
    var bookList : [Book] = [
        Book(bookTitle: "딸아 주식공부 하자", bookImage: "book1", bookrating: 7.8),
        Book(bookTitle: "바이오 머니가 온다", bookImage: "book2", bookrating: 8.8),
        Book(bookTitle: "인플레이션에서 살아남기", bookImage: "book3", bookrating: 6.8),
        Book(bookTitle: "월급쟁이 부자로 은퇴하라", bookImage: "book4", bookrating: 7.2),
        Book(bookTitle: "부를 재편하는 금육 대혁명", bookImage: "book5", bookrating: 7.9),
        Book(bookTitle: "브라질에 비가 내리면 스타벅스 주식을 사라", bookImage: "book6", bookrating: 8.6),
        Book(bookTitle: "부의 비밀지도", bookImage: "book6", bookrating: 5.8),
        Book(bookTitle: "파이어 FIRE", bookImage: "book7", bookrating: 7.2),
        Book(bookTitle: "부의 인문학(20만부 기념 개정증보판)", bookImage: "book8", bookrating: 9.8),
        Book(bookTitle: "나의 투자는 새벽 4시에 시작된다", bookImage: "book9", bookrating: 5.8),
        Book(bookTitle: "아들아 돈 공부해야 한다(10만부 기념 골드 에디션)", bookImage: "book10", bookrating: 9.8)
    ]
    
    var color : [UIColor] = [.init(red: 192, green: 128, blue: 203), .init(red: 121, green: 97, blue: 120), .init(red: 253, green: 130 , blue: 118), .init(red: 52, green: 136, blue: 182)]
    
    
}
