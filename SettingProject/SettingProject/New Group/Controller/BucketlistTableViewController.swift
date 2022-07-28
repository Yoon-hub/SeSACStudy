//
//  BucketlistTableViewController.swift
//  SettingProject
//
//  Created by 최윤제 on 2022/07/19.
//

import UIKit

struct Todo{
    var title : String
    var done: Bool
}

class BucketlistTableViewController: UITableViewController {
    
    static let identifier = "BucketlistTableViewController"
    

    //list 프로퍼티가 추가, 삭제 변경 되고 나서 테이블뷰를 항상 갱신!
    var list = [Todo(title: "탑건", done: false), Todo(title: "범죄도시2", done: false)]{
        didSet{
            tableView.reloadData()
        }
    }
    
    var textfieldPlaceholder = ""

    //class는 ReferenceType -> 인스턴스 자체를 변경하지 않는 이상 한 번만 될 거다!
    //IBOullet viewDidLoad 호출 되기 직전에 nil이 아닌 지 알 수 있음
    @IBOutlet weak var userTextField: UITextField!{
        didSet{
            print("ViewDidLoad가 실행되기 직전에 실행")
            userTextField.textColor = .systemRed
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTextField.placeholder = textfieldPlaceholder
        navigationItem.title = "버킷리스트"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        tableView.rowHeight = 60
  
        
    }
    @objc func closeButtonClicked(){
        self.dismiss(animated: true)
    }
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        
        if let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count){
            list.append(Todo(title: sender.text!, done: false))
            tableView.reloadData()
        } else {
            //토스트 메시지 띄우기
        }
        
        guard let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) else {
            return
        }
        list.append(Todo(title: sender.text!, done: false))
        tableView.reloadData()
        
        //중요
        //tableView.reloadData()

    }
    //section수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //cell수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    //cell 커스텀
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BucketlistTableViewCell", for: indexPath) as! BucketlistTableViewCell // as? 타입 캐스팅
        
        cell.bucketListLabel.text = list[indexPath.row].title
        cell.bucketListLabel.font = .boldSystemFont(ofSize: 18)
        
        cell.checkBoxButton.tag = indexPath.row
        cell.checkBoxButton.addTarget(self, action: #selector(checkBoxButtonClicked(sender: )), for: .touchUpInside)
        
        let value = list[indexPath.row].done ? "checkmark.square" : "checkmark.square.fill"
        cell.checkBoxButton.setImage(UIImage(systemName: value), for: .normal)
        
        return cell
        
    }
    
    @objc func checkBoxButtonClicked(sender: UIButton){
        print("\(sender.tag) 번쨰 버튼 클릭!")
            
        list[sender.tag].done = !list[sender.tag].done
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        
        //재사용 셀 오류 확인용 코드
        //sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
    }
    
    
    //편집 가능하게 cell 활성화
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    //우측 스와이프 디폴트 기능: commit editingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            //배열 삭제 후 테이블 뷰 갱신
            list.remove(at:indexPath.row)
            tableView.reloadData()
        }
    }
    

}

