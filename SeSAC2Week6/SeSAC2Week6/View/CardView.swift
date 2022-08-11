//
//  CardView.swift
//  SeSAC2Week6
//
//  Created by 최윤제 on 2022/08/09.
//

import UIKit

/*
 Xml Interface Builder
 1. UIView Costom Class
 2. File's owner => 확장성이 올라간다는디?
 */
class CardView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    
    // 프로토콜의 init을 채택
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let view = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds
        view.backgroundColor = .gray
        self.addSubview(view)  // 코드를 기반으로 추가 해주어서
        
        // 카드뷰를 인터페이스 빌더 기반으로 만들고, 레이아웃도 설정했는데 false가 아닌 true로 나온다...
        //true. 오토레이아웃 적용이 되는 관점보다 오토리사이징이 내부적으로 constraints처리가 됨
        print(view.translatesAutoresizingMaskIntoConstraints)
    }

}
