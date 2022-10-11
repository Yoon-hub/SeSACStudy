//
//  GCDViewController.swift
//  SeSAC2Week9
//
//  Created by 최윤제 on 2022/09/02.
//

import Foundation
import UIKit
//GCD(Grand Cental Dispatch)
class GCDViewController: UIViewController {
    
    let url1 = URL(string: "https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_5000.jpg")!
    let url2 = URL(string: "https://apod.nasa.gov/apod/image/2112/M3Leonard_Bartlett_3843.jpg")!
    let url3 = URL(string: "https://apod.nasa.gov/apod/image/2112/LeonardMeteor_Poole_2250.jpg")!
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var image3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //Serial 은 혼자서
    //Concurrent는 여러명
    // Sync는 queue에 안넣고
    // Async는 queue에 넣고
    
    //혼자서 순서를 기다리면서
    //직별 동기 -> 닭혼자서 순서대로 일한다
    @IBAction func mainsync(_ sender: UIButton) {
        print("Start")
        
        DispatchQueue.main.sync {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        
        
        print("END")
    }
    //혼자서 일을 큐에 넣어 두고 한다.
    //직별 비동기 -> 닭 혼자서 일한다
    @IBAction func mainasync(_ sender: UIButton) {
        
        print("Start")
        
        DispatchQueue.main.async { // 보내 버리고 다음 작업 실행
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END")
        
    }
    
    //여러명이서 순서대로
    //병렬 동기: 여러명 한테 일을 주지만 일을 순서대로 한다! -> 사용 x
    @IBAction func golobalsync(_ sender: Any) {
        print("Start")
        //여러 알바생한테 일을 나누어 주었다
        //queue 에 있는 작업이 끝나지 전까지 기다린다.
        //apple은 의미 없어서 main thread로 옮겨 버린다.
        DispatchQueue.global().sync {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END")
    }
    
    //여러명이서 동시에 시작한다.
    @IBAction func globalasync(_ sender: UIButton) {
        print("start\(Thread.isMainThread)")
        
        DispatchQueue.global().async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        print("END\(Thread.isMainThread)")
        
    }
    //중요한 일에는 부스터를 달아주는 개념
    @IBAction func qos(_ sender: UIButton) {
        
        let customQueue = DispatchQueue(label: "concurrrentSeSAC", qos: .userInteractive, attributes: .concurrent)
        customQueue.async {
            print("START")
        }
        
        DispatchQueue.global(qos: .background).async { // 가장 낮은 순위
            for i in 1...100 {
                print(i, terminator: " ")
            }
            
        }
        
        DispatchQueue.global(qos: .userInteractive).async { //가장 높은 순위
            for i in 101...200 {
                print(i, terminator: " ")
            }
            
        }
        
        DispatchQueue.global(qos: .utility).async {
            for i in 201...300 {
                print(i, terminator: " ")
            }
            
        }
        
        
    }
    
    @IBAction func dispatchGroup(_ sender: UIButton) {
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100{
                print(i, terminator: " ")
            }
        }
        DispatchQueue.global().async(group: group) {
            for i in 101...200{
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 201...300{
                print(i, terminator: " ")
            }
        }
        
        group.notify(queue: .main) {
            print("끝")  //tableView.reload
        }
        
    }
  
    func request(url: URL, completionHandler: @escaping (UIImage?) -> Void) {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    completionHandler(UIImage(systemName: "star"))
                    return
                }

                let image = UIImage(data: data)
                completionHandler(image)
                                      
            }.resume()
        }
    
    
    @IBAction func dispatchGroupNASA(_ sender: UIButton) {
        
//        request(url: url1) { image in
//            print("1")
//            self.request(url: self.url2) { image in
//                print("2")
//                self.request(url: self.url3) { image in
//                    print("3")
//                }
//            }
//        }
//
        //내부 함수가 비동기 이면  enter / leave 를 통해서 확인한다
       let group = DispatchGroup()
        DispatchQueue.global().async(group: group) {
            //안에 구문은 또다른 글로벌 비동기로 실행이 되고 이 클로저는 종료가 된다.
            self.request(url: self.url1) { iamge in
                print(1)
            }
        }
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url2) { iamge in
                print(2)
            }
        }

        DispatchQueue.global().async(group: group) {
            self.request(url: self.url3) { iamge in
                print(3)
            }
        }
        
        group.notify(queue: .main) {
            print("끝")
        }

        
    }
    
    @IBAction func enterLeave(_ sender: UIButton) {
        let group = DispatchGroup()
        
        var imageList: [UIImage] = []
        
        group.enter() // RC + 1
        request(url: url1) { image in
            imageList.append(image!)
            group.leave()
        }
        
        group.enter()
        request(url: url2) { image in
            imageList.append(image!)
            group.leave()
        }
        
        group.enter()
        request(url: url3) { image in
            imageList.append(image!)
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("끝. 완료.")
            self.image1.image = imageList[0]
            self.image2.image = imageList[1]
            self.image3.image = imageList[2]
            
        }
        
        
    }
    
    @IBAction func raceCondition(_ sender: UIButton) {
        let group = DispatchGroup()
        
        var nickname = "SeSAC"
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "고래밥"
            print("first: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "칙촉"
            print("second: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "올라프"
            print("third: \(nickname)")
        }
        
        group.notify(queue: .main) {
            print("result: \(nickname)")
        }
        
    }
    
    
    
}
