//
//  TimbrumTests.swift
//  TimbrumTests
//
//  Created by Simone Genovese on 23/02/16.
//  Copyright © 2016 ESTECO. All rights reserved.
//

import XCTest
@testable import Timbrum

class ZucchettiTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testReturnValueIsZeroIfSliderIsNotOne() {
        let zucchettiController = ZucchettiController()
        let listener = StubListener()
        zucchettiController.addListener(listener)
        zucchettiController.connect("http://zucchetti.toshiro.it/app_dev.php")
        sleep(4)
        let resstr = NSString(data: listener.getData(), encoding: NSUTF8StringEncoding)
        XCTAssertTrue(resstr!.containsString("<title>Symfony - Welcome</title>"))

    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

    class StubListener: ZucchettiListener {

        var globalData: NSData = NSData()

        func loadComplete(data: NSData) {
            globalData = data
        }

        func getData() -> NSData {
            return globalData
        }
    }

}
