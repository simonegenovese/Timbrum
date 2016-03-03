//
//  TimbrumTests.swift
//  TimbrumTests
//
//  Created by Simone Genovese on 23/02/16.
//  Copyright © 2016 ESTECO. All rights reserved.
//

import XCTest
@testable import Timbrum

class TimbrumTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testReturnValueIsZeroIfSliderIsNotOne() {
        let viewController = ViewController()
        let result = viewController.checkSlider(0.1)
        XCTAssert(result == 0.5)
    }

    func testReturnOneIfSlidePositionIsOne() {
        let viewController = ViewController()
        let result = viewController.checkSlider(1.0)
        XCTAssert(result == 1.0)
    }

    func testReturnMinusOneIfSlidePositionIsMinusOne() {
        let viewController = ViewController()
        let result = viewController.checkSlider(0.0)
        XCTAssert(result == 0.0)
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
