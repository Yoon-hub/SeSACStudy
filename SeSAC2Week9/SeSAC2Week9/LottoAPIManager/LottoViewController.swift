//
//  LottoViewController.swift
//  SeSAC2Week9
//
//  Created by 최윤제 on 2022/09/01.
//

import Foundation
import UIKit

class LottoViewController: UIViewController {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var viewModel = LottoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.viewModel.fetchLottoAPI(drwNo: 1000)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.viewModel.fetchLottoAPI(drwNo: 1002)
        }
        
        bindData()
    }
    
    func bindData() {
        //이렇게 listener를 등록해주면 value만 바꾸면 된다람쥐
        viewModel.number1.bind { value in
            self.label1.text = String(value)
        }
        viewModel.number2.bind { value in
            self.label2.text = String(value)
        }
        viewModel.lottoMoney.bind { value in
            self.dateLabel.text = value
            
        }
    }
    
    func requestLottot(drwNo: Int, comletion: @escaping (Lotto?, APIError?) -> () ) {
        
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)")!
        
        let config = URLSessionConfiguration.default
        let defaultSession = URLSession(configuration: config, delegate: self, delegateQueue: nil)
                
        let Task = defaultSession.dataTask(with: url)
        Task.resume()
        
    }
    
}

extension LottoViewController: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
    }
    
}

