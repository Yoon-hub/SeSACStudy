//
//  BackViewController.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/25.
//

import UIKit
import SnapKit
import Zip

class BackViewController: BaseViewController {
    let tableView = UITableView()
    
    override func viewDidLoad() {

        fetchDocumentZipFile()
        
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(BackTableViewCell.self, forCellReuseIdentifier: "BackTableViewCell")
        
        [tableView].forEach {
            view.addSubview($0)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        let backup = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupButtonClicked))
        let recover = UIBarButtonItem(title: "복구", style: .plain, target: self, action: #selector(recoverButtonClicked))
        
        navigationItem.rightBarButtonItems = [backup, recover]
    }
    
    @objc func backupButtonClicked() {
        
        var urlPaths = [URL]()
        
        //도큐먼트 위치에 백업 파일 확인
        guard let path = documentDirectoryPath() else {
           showAlert("도큐먼트 위치 오류발생")
            return
        }
        //도큐먼트 폴더안의 realm파일의 경로
        let reamFile = path.appendingPathComponent("default.realm")
        
        //파일이 존재 하는지 확인
        guard FileManager.default.fileExists(atPath: reamFile.path) else {
            showAlert("파일이 존재 하지 않슴다")
            return
        }
        
        // url 배열에 추가
        urlPaths.append(URL(string: reamFile.path)!)
        
        //백업 파일을 압축: URL
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "SeSACDiary_1")
            print("Archive Loction: \(zipFilePath)")
            showAcitictyViewController()
        } catch {
            showAlert("압축을 실패했습니다.")
        }
        
        //ActivityViewController
    }
    
    @objc func recoverButtonClicked() {
        
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)
        
    }
    
    func showAcitictyViewController() {
        
        guard let path = documentDirectoryPath() else {
           showAlert("도큐먼트 위치 오류발생")
            return
        }
        
        //도큐먼트 폴더안의 realm파일의 경로
        let backupFileURL = path.appendingPathComponent("SeSACDiary_1.zip")
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }

}

extension BackViewController: UIDocumentPickerDelegate {
    
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
    
            let fileURL = path.appendingPathComponent("SeSACDiary_1.zip")
            
            do{
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlert("복구가 완료 되었습니다.")
                })
            } catch {
                showAlert("압축 해제에 실패했습니다.")
            }
            
        } else {
            
            do {
                //파일 앱의 zip -> 도큐먼트 폴더에 복사
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent("SeSACDiary_1.zip")
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlert("복구가 완료 되었습니다.")
                    // 앱을 새로운 윈도우로 실행 시켜저야한다.
                })
                
            } catch {
                showAlert("압축 해제에 실패했습니다.")
            }
        }
        
    }
    
}


extension BackViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BackTableViewCell", for: indexPath) as! BackTableViewCell
        cell.label.text = "hi"
        cell.label.textColor = .black
        return cell
    }
    
    
}

