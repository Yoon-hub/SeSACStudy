//
//  ViewController.swift
//  SeSAC2Week9
//
//  Created by 최윤제 on 2022/08/30.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lottoLable: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = PersonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let user = UserName("고래밥")
        
        user.bind { name in
            print("이름이 \(name)으로 바뀌었습니다")
        }
        
    
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        
        
        LottoAPIManager.requestLottot(drwNo: 1011) { lotto, error in
            guard let lotto = lotto else {
                return
            }
      
            // self.lottoLable.text = lotto.drwNoDate
        }
        
        viewModel.fetchPerson(query: "kim")
        
        viewModel.list.bind { person in
            print("viewcontroller bind")
            
            self.tableView.reloadData()
        }

    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let data = viewModel.cellForRowAt(at: indexPath)
        
        cell.textLabel!.text = data.name
        cell.detailTextLabel!.text = data.knownForDepartment
        
        return cell
    }
    
    
}
