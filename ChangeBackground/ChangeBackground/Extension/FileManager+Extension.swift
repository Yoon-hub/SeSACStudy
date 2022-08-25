//
//  FileManager+Extension.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/24.
//

import UIKit
extension UIViewController{
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        //Document의 경로를 알려주는 코드
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        //세부 파일 경로. 이미지를 저장할 위치
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "star.fill")
        }
        
        
    }
    
    func removeImageFromDocument(fileName: String) {
        //Document의 경로를 알려주는 코드
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        //세부 파일 경로. 이미지를 저장할 위치
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
        
    }
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        //세부 파일 경로. 이미지를 저장할 위치
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        //용량을 줄이기 위해 압축하는 것
        guard let data = image.jpegData(compressionQuality: 0.5) else {return}

        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
    }
    
    
    func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil} //Docuemnt 경로
        return documentDirectory
    }
    
    func fetchDocumentZipFile() {
        
        do {
            guard let path = documentDirectoryPath() else {return}
            
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            print("docs: \(docs)")
            
            let zip = docs.filter { $0.pathExtension == "zip" }
            print("zip: \(zip)")
            
            let result = zip.map { $0.lastPathComponent }
            
            print("rseult: \(result)")
        } catch {
            print("ERROR")
        }
    }
    
    
}
