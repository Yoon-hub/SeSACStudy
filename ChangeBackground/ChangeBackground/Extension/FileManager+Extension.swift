//
//  FileManager+Extension.swift
//  ChangeBackground
//
//  Created by 최윤제 on 2022/08/24.
//

import UIKit

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

func removeImageFromDocument(fileName: String){
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
