//
//  XCTestTestTests.swift
//  XCTestTestTests
//
//  Created by 최윤제 on 2022/11/29.
//

import XCTest
@testable import XCTestTest

final class XCTestTestTests: XCTestCase {
    
    var sut: ViewController! // system nuder test 의 줄임말 테스트를 하고자하는 클래스를 정의할 때 사용!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController
        sut.loadViewIfNeeded() // 스토리보드 및 @IBOutlet 시에 필요!
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    //이메일 유효성 테스트
    //TDD 유닛테스트할 떄 사용하는 구조?
    //BDD
    func testViewController_vaildEmail_returnTrue() throws {
        
        //테스트 객체: Given, Arragne
        sut.emailTextFeild.text = "jack@jack.com"
        //테스트 조건/행동: When, Act
        let valid = sut.isValidEmail()
        //테스트 결과: Then, Assert
        XCTAssertTrue(valid) // 테스트 성공
    }
    
    func testViewCOntroller_inVaildPassword_RetrunFalse() throws {
        sut.passwdTextField.text = "1234"
        
        let vaild = sut.isValidPassword()
        
        XCTAssertFalse(vaild)
    }
    
    func testViewController_emailTextField_ReturnNill() throws {
        sut.emailTextFeild = nil
        
        let value = sut.emailTextFeild
        
        XCTAssertNil(value)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}



