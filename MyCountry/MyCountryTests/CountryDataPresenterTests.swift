//
//  MyCountryTests.swift
//  MyCountryTests
//
//  Created by Dimil T Mohan on 7/24/18.
//  Copyright © 2018 Dimil T Mohan. All rights reserved.
//

import XCTest
@testable import MyCountry

class CountryDataPresenterTests: XCTestCase {
    var presenter = CountryDataPresenter()


    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchRequest() {
        presenter.manager = CountryDataManager()
        presenter.fetchCountryData()
        let expectation = self.expectation(description:"Request")
        DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
            XCTAssertNotNil(self.presenter.cointryDetails, "cointryDetails should not be nil")
            XCTAssertNotNil(self.presenter.viewTitle, "viewTitle should not be nil")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
    }

    func testReturnTheDataModelForIndex(){
        presenter.manager = CountryDataManager()
        presenter.fetchCountryData()
        let expectation = self.expectation(description:"Request")
        DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
            XCTAssertNotNil(self.presenter.returnTheDataModelForIndex(index: 0), "returnTheDataModelForIndex should return object")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
    }
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            presenter.fetchCountryData()
        }
    }
    }


    

