//
//  TrendTableViewController.swift
//  SettingProject
//
//  Created by 최윤제 on 2022/07/21.
//

import UIKit

class TrendTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }



    @IBAction func movieButtonClicked(_ sender: UIButton) {
        
        //영화 버튼을 클릭하면 > BucketListTableViewController Present 형식으로
        // 1. 포함되고 있는 스토리보드 파일 찾기
        // 2. 뷰컨트롤러 찾기
        // 3. 어떤 방식으로 띄어 줄것 이냐
        
        //1
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        //2
        let vc = sb.instantiateViewController(withIdentifier: BucketlistTableViewController.identifier) as! BucketlistTableViewController
        //3
        self.present(vc, animated: true)
        
    }
    
    @IBAction func dramaButtonClicked(_ sender: UIButton) {
        //1
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        //2
        let vc = sb.instantiateViewController(withIdentifier: BucketlistTableViewController.identifier) as! BucketlistTableViewController
        //2.5 present 시 화면 옵션
        vc.modalPresentationStyle = .fullScreen
        //3
        self.present(vc, animated: true)
        
        
    }
    
    @IBAction func bookButtonClicked(_ sender: UIButton) {
        //1
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        //2
        let vc = sb.instantiateViewController(withIdentifier: BucketlistTableViewController.identifier) as! BucketlistTableViewController
        //2.5
        let navi = UINavigationController(rootViewController: vc)
        
        
        //2.5 present 시 화면 옵션
        navi.modalPresentationStyle = .fullScreen
        //3
        self.present(navi, animated: true)

    }
}



