//
//  APIServiceTests.swift
//  XCTestTestTests
//
//  Created by 최윤제 on 2022/12/01.
//

import XCTest
@testable import XCTestTest

final class APIServiceTests: XCTestCase {
    
    var sut: APIService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = APIService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testExample() throws {
        print("testXample Start")
        
        sut.number = 100
        sut.callRequest { value in
            XCTAssertLessThanOrEqual(value, 45)
            XCTAssertGreaterThanOrEqual(value, 1)
        }
        print("testXample End")
    }
    
    
    //비동기: expectation, fulfill, wait
    /*
     네트워크: 아이폰 네트워크 응답X. API 서버 점검, API 지연..? >>
     효율적/속도/같은 조건에서 테스틀 해야 하는데 그 조건 꺠짐
     테스트 대상이 외부 격리X -> 예측 불가능한 상황을 만들면 안돼
     => 실제 네트워크 동작이 되는 것 처럼 보이게 별개의 객체를 만듬!
     => 테스트 더블(Test Double): 테스트 코드랑 상화작용 할 수 있는 가짜 객체 생성(ex. 스턴트맨)
        ex. dummy, mock, fake, stub, spy ...
     
     테스트 원칙
     F,I,R,S,T
     Fast: 뷰컨트롤 분리해서 빠르게, Isolated: 고립, Repeatable: 반복하더라도 같은 결과 이원칙을 달성하기 위한 테스트 더블, SELf-validation: XCTest를 사용하라, Timely: 적절하게 로또라면 1부터 45다 해보쟈구요 항상 철저하게 모든 데이터의 검사를 해
     
     
    XCTest의 오픈소스 quick
     */
    //10
    func test_APILottoResponse_AsyncCover() throws {
        print("testXample Start")
        
        let promise = expectation(description: "로또 넘버 응답이 올 때 까지 기다리는 거임") // 약속잡아
    
        sut.number = 33
        
        sut.callRequest { value in
            XCTAssertLessThanOrEqual(value, 45)
            XCTAssertGreaterThanOrEqual(value, 1)
            print("callRequest")
            promise.fulfill() // expecation으로 정의된 테스트 조건을 충족!!
        }
        print("testXample End")
        
        wait(for: [promise], timeout: 5) // 5초동안 기다려 볼게
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
