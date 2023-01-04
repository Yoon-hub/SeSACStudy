//
//  XCTestTestUITests.swift
//  XCTestTestUITests
//
//  Created by 최윤제 on 2022/11/29.
//

import XCTest
@testable import XCTestTest

final class XCTestTestUITests: XCTestCase {

    override func setUpWithError() throws {  // 테스트가 실행 될때 각 test마다 하나씩 실행
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false // 실패하면 멈추라

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws { // 테스트가 종료될때
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication() // 앱의 실행과 종료를 도와줌
        app.launch()
        
        app.textFields["email"].tap()
        app.textFields["email"].typeText("jack@jack.com")
        
        
    }/*
      Code Coverage 코드 커버리지. 테스트 가치.
      */
    
    func testLoginExample() throws {
        let app = XCUIApplication() // 앱의 실행과 종료를 도와줌
        app.launch()
        
        app.textFields["passwd"].tap()
        app.textFields["passwd"].typeText("12341234")
        
        //XCTAssertEqual(5, 9)
        
        app.textFields["check"].tap()
        app.textFields["check"].typeText("12345678")
        
        app.staticTexts["로그인하기"].tap()
        
        let label = app.staticTexts.element(matching: .any, identifier: "label").label
        XCTAssertEqual(label, "로그인 버튼을 눌렀습니다.")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
