//
//  ValidatorTests.swift
//  XCTestTestTests
//
//  Created by 최윤제 on 2022/11/30.
//

import XCTest
@testable import XCTestTest

final class ValidatorTests: XCTestCase {
    
    var sut: Validator!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = Validator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    //UI적인 측면의 코드를 덜어낸것
    //빨리. 고립(다른 테스트에 영향 x). 항상 같은 결과(Repeatable)
    func testValidator_validEmail_returnTrue() throws {
        let user = User(email: "jack@jack.com", password: "1234", check: "1234")
        let valid = sut.isValidEmail(email: user.email)
        XCTAssertTrue(valid)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
