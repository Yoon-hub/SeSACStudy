//
//  LocalizableViewController.swift
//  SeSAC2Week9
//
//  Created by 최윤제 on 2022/09/06.
//

import UIKit
import CoreLocation
import MessageUI // 메일로 문의 보내기

class LocalizableViewController: UIViewController, MFMailComposeViewControllerDelegate {

    
    @IBOutlet weak var sampleButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "navigation_title".localized
        
        //나는 0살입니다
        //I am 8 ages
        
        let buttonTitle = "common_cancel".localized
        sampleButton.setTitle(buttonTitle, for: .normal)
        searchBar.placeholder = "search_placeholder".localized
        
        inputTextField.placeholder = "textfield_placeholder".localized
        myLabel.text = "introduce".localized(with: "고래밥")
        //String(format: "introduce".localized, "고래밥")
        
        CLLocationManager().requestWhenInUseAuthorization()

    }
    
    func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            
            let mail = MFMailComposeViewController()
            mail.setToRecipients(["kong4170@naver.com"])
            mail.setSubject("고래밥 다이어리 문의사항 -")
            mail.mailComposeDelegate = self
            
            self.present(mail, animated: true)
        } else {
            //alert. 메일 등록을 해주시거나, jack@Jack.com으로 문의 주세요
            print("Alert")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            <#code#>
        case .saved:
            <#code#>
        case .sent:
            <#code#>
        case .failed:
            <#code#>
        }
    }
}

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with: String) -> String {
        return String(format: self.localized, with)
    }
    
    func localized(number: Int) -> String {
        return String(format: self.localized, number)
    }
    
}

/*
 리뷰 남기기 -> 리뷰 얼럿: 1년에 한 디바이스 당 3회 // SKStoreReviewController
 
 
 
 */
