//
//  CountryDataManager.swift
//  MyCountry
//
//  Created by Dimil T Mohan on 7/25/18.
//  Copyright © 2018 Dimil T Mohan. All rights reserved.
//

import XCTest
@testable import MyCountry

class CountryDataManagerTests: XCTestCase {
    var manager = CountryDataManager()
    override func setUp() {
        super.setUp()

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequestCountryData() {
        let expectation = XCTestExpectation(description: "Download apple.com home page")
        manager.requestContryData{data in
            XCTAssertNotNil(data?.dataList, "data?.dataList should not be nil")
            XCTAssertNotNil(data?.title, "data?.title should not be nil")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            manager.requestContryData{data in
                
            }
        }
    }
    
}
