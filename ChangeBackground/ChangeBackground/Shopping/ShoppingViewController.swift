//
//  ShoppingViewController.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/22.
//

import UIKit
import RealmSwift
import Network
import Zip

class ShoppingViewController: BaseViewController {
    
    let shoppingView = ShoppingView()
    let localRealm = try! Realm()
    var zipName: String!
    
    var tasks: Results<UserShoppingList>! {
        didSet {
            shoppingView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = shoppingView
        
        fetchRealm()
        print(documentDirectoryPath()!)
    
        shoppingView.tableView.register(ShoppingTableViewCell.self, forCellReuseIdentifier: ShoppingTableViewCell.reusable)
        shoppingView.tableView.dataSource = self
        shoppingView.tableView.delegate = self
        shoppingView.plusButton.addTarget(self, action: #selector(plusButtonClicked), for: .touchUpInside)
        shoppingView.tableView.rowHeight = 50
        
        let children: [UIAction] = {
            let nameSort = UIAction(title: "이름순", image: UIImage(systemName: "arrow.up.arrow.down.square"), handler: { _ in
                self.tasks = self.localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "shopThing", ascending: false) })
            let heartSort = UIAction(title: "즐겨찾기순", image: UIImage(systemName: "arrow.up.arrow.down.square"), handler: { _ in self.tasks = self.localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "favortie", ascending: false) })
            return [nameSort, heartSort]
        }()
        
        let menu = UIMenu(title: "정렬", image: nil, identifier: nil, options: .displayInline, children: children)

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "arrow.up.arrow.down.square"), primaryAction: nil, menu: menu)
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        
        let backup = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupButtonClicked))
        let recover = UIBarButtonItem(title: "복구", style: .plain, target: self, action: #selector(recoverButtonClicked))
        
        navigationItem.leftBarButtonItems = [backup, recover]
        
      
    }
    
    @objc func backupButtonClicked() {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("default.realm")
        let imageDirectoryURL = documentDirectory.appendingPathComponent("image")
        
        guard FileManager.default.fileExists(atPath: fileURL.path), FileManager.default.fileExists(atPath: imageDirectoryURL.path) else {
            showAlert("파일이 존재 하지 않슴다")
            return
        }
        
        let urlPaths = [fileURL, imageDirectoryURL]
        
        do {
            
            let format = DateFormatter()
            format.dateFormat = "yyyyMMddhhmmss"
            zipName = "SeSACDiary_" + format.string(from: Date())
            
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: zipName)
            print("Archive Loction: \(zipFilePath)")
            showAcitictyViewController() // AcitictyViewController()를 통해서 백업파일 위치를 정하게 해준다
        } catch {
            showAlert("압축을 실패했습니다.")
        }
        
    }
    
    func showAcitictyViewController() {
        
        guard let path = documentDirectoryPath() else {
           showAlert("도큐먼트 위치 오류발생")
            return
        }
        
        //도큐먼트 폴더안의 realm파일의 경로
        let backupFileURL = path.appendingPathComponent(zipName + ".zip")  // Document 폴더안에 저장된 zip 파일을 찾아서 어디 따로 저장할지
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
    @objc func recoverButtonClicked() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
         documentPicker.delegate = self
         documentPicker.allowsMultipleSelection = false
         self.present(documentPicker, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRealm()
    }
    
    func fetchRealm() {
        tasks = localRealm.objects(UserShoppingList.self)
    }
    
    @objc
    func plusButtonClicked() {
        let task = UserShoppingList(shopThing: shoppingView.textField.text!) // 추가
        
        try! localRealm.write {
            localRealm.add(task) //Create
        }

        shoppingView.tableView.reloadData()
        
    }
    
}
//MARK: - DocumentPicker
extension ShoppingViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        //선택한 파일 위치를 가져오기
        guard let selectedFileURL = urls.first else {
            showAlert("선택하신 파일을 찾을 수 없습니다.")
            return
        }
        //도큐먼트 위치 가져오기
        guard let path = documentDirectoryPath() else {
           showAlert("도큐먼트 위치 오류발생")
            return
        }
        // 선택한 파일과 도큐먼트 위치를 합치기
        // 도큐먼트에 선택한 파일이 있냐를 묻는거네
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
    
            //let fileURL = path.appendingPathComponent("SeSACDiary_1.zip")
            
            do{
                try Zip.unzipFile(sandboxFileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlert("복구가 완료 되었습니다.")
                    
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let sceneDelegate = windowScene?.delegate as? SceneDelegate

                    let vc = ShoppingViewController()
                    let navi = UINavigationController(rootViewController: vc)

                    sceneDelegate?.window?.rootViewController = navi
                    sceneDelegate?.window?.makeKeyAndVisible()
                    
                })
            } catch {
                showAlert("압축 해제에 실패했습니다.")
            }
            
        } else {
            
            do {
                //파일 앱의 zip -> 도큐먼트 폴더에 복사
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                //let fileURL = path.appendingPathComponent("SeSACDiary_1.zip")
                
                try Zip.unzipFile(sandboxFileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlert("복구가 완료 되었습니다.")
                    
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let sceneDelegate = windowScene?.delegate as? SceneDelegate

                    let vc = ShoppingViewController()
                    let navi = UINavigationController(rootViewController: vc)

                    sceneDelegate?.window?.rootViewController = navi
                    sceneDelegate?.window?.makeKeyAndVisible()
                    // 앱을 새로운 윈도우로 실행 시켜저야한다.
                })
                
            } catch {
                showAlert("압축 해제에 실패했습니다.")
            }
        }
        
    }
    
}

//MARK: - TableView
extension ShoppingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingTableViewCell.reusable, for: indexPath) as? ShoppingTableViewCell else { return UITableViewCell() }
        
        cell.label.text = tasks[indexPath.row].shopThing
        
        let starButtonimage = tasks[indexPath.row].favortie ? "star.fill" : "star"
        cell.starButton.setImage(UIImage(systemName: starButtonimage), for: .normal)
        
        cell.starButton.tag = indexPath.row
        cell.starButton.addTarget(self, action: #selector(starButtonClicekd(_:)), for: .touchUpInside)
        
        let checkButtonimage = tasks[indexPath.row].checkBox ? "checkmark.square.fill" : "checkmark.square"
        cell.checkButton.setImage(UIImage(systemName: checkButtonimage), for: .normal)
        
        cell.checkButton.tag = indexPath.row
        cell.checkButton.addTarget(self, action: #selector(checkButtonClicekd(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteButton = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            self.deleteImageToDocument(fileName: "\(self.tasks[indexPath.row].objectID).jpg")
            
            try! self.localRealm.write {
                self.localRealm.delete(self.tasks[indexPath.row])
                self.fetchRealm()
              }
            
        }
        deleteButton.image = UIImage(systemName: "xmark.diamond.fill")
        deleteButton.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteButton])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ShoppingDetailVC()
        vc.thingLabel.text = tasks[indexPath.row].shopThing
        vc.favoriteLabel.text = tasks[indexPath.row].favortie ? "즐겨찾기를 했어요!" : "즐겨찾기를 안했어요!"
        vc.checkBoxLabel.text = tasks[indexPath.row].checkBox ? "체크를 했어요!" : "체크를 안했어요!"
        vc.objectId = tasks[indexPath.row].objectID
        vc.selectImageView.image = loadImageToDocument(fileName: "\(tasks[indexPath.row].objectID).jpg")
        present(vc, animated: true)
    }
    
    func loadImageToDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        //세부 파일 경로. 이미지를 저장할 위치
        let imageURL = documentDirectory.appendingPathComponent("image")
        let fileURL = imageURL.appendingPathComponent(fileName)
        
        let image = UIImage(contentsOfFile: fileURL.path)

        return image
    }
    
    func deleteImageToDocument(fileName: String){
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        //세부 파일 경로. 이미지를 저장할 위치
        let imageURL = documentDirectory.appendingPathComponent("image")
        let fileURL = imageURL.appendingPathComponent(fileName)

        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }

    }
    
    @objc func starButtonClicekd(_ startButton: UIButton) {
            
        try! localRealm.write {
            tasks[startButton.tag].favortie = !tasks[startButton.tag].favortie
            self.fetchRealm()
        }
    }
    
    @objc func checkButtonClicekd(_ checkButton: UIButton) {
        
        try! localRealm.write {
            tasks[checkButton.tag].checkBox = !tasks[checkButton.tag].checkBox
            self.fetchRealm()
        }
    }


    
}
