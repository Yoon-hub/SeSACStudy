//
//  CodeSnap2ViewController.swift
//  SeSAC2Week7Diary
//
//  Created by 최윤제 on 2022/08/17.
//

import UIKit
import SnapKit

class CodeSnap2ViewController: UIViewController {
    
    let blackView: UIView = { (name: String) -> (UIView) in
        let view = UIView()
        view.backgroundColor = .black
        return view
    }("hi")
    
    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let yellowView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        [redView, blackView].forEach {
            view.addSubview($0)
        }
        
        redView.addSubview(yellowView) // ContatinerView, stackView
        
        redView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view)
        }
        
        //RTL 아랍에서는 left와 right가 반대여서!
        blackView.snp.makeConstraints { make in
            //make.edges.equalTo(redView).offset(50)
            make.edges.equalTo(redView).inset(50)
            
        }
        
        yellowView.snp.makeConstraints { make in
            make.edges.equalTo(redView).inset(20)
        }
        
    }
    
}
