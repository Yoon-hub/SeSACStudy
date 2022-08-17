//
//  ViewController.swift
//  SeSAC2Week7Diary
//
//  Created by 최윤제 on 2022/08/16.
//  접근 제어 안할 시 internal 로 설정된다. 

import UIKit
import SeSAC2UIFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = CodeSnapViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
        testOpen()
//        showSesacAlert(title: "테스트", message: "테스트 메세지", buttonTitle: "변경") { _ in
//            self.view.backgroundColor = .lightGray
//
//        }
//        let image = UIImage(systemName: "star.fill")!
//        let shareURL = "https://www.apple.com"
//        let text = "WWDC What's New!!"
//        sesacShowActivityViewController(shareImage: image, shareURL: shareURL, shareText: text)
//
//
        let web = OpenWebView.presentWebViewController(self, url: "https://www.naver.com", transitionStyle: .present)
        
        
      
    }
}

