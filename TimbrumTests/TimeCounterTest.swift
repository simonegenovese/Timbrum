//
//  TimeCounterTest.swift
//  Timbrum
//
//  Created by Simone Genovese on 09/03/16.
//  Copyright © 2016 ESTECO. All rights reserved.
//

import XCTest
@testable import Timbrum

class TimeCounterTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTimeAdd() {
        let timeCounter = TimeCounter()
        timeCounter.entrata("0304")
        XCTAssertEqual("03:04", timeCounter.getOreTotali())
    }

    func testTimeAddAndRemove() {
        let timeCounter = TimeCounter()
        timeCounter.entrata("0304")
        timeCounter.uscita("0404")
        XCTAssertEqual("01:00", timeCounter.getOreTotali())
    }

    func testTimeMultipleAdd() {
        let timeCounter = TimeCounter()
        timeCounter.entrata("0304")
        timeCounter.entrata("0304")
        XCTAssertEqual("06:08", timeCounter.getOreTotali())
    }


    func testTimeAddAndRemoveTable() {
        let timeCounter = TimeCounter()
        timeCounter.entrata("0304")
        timeCounter.uscita("0300")
        let timeTable = timeCounter.getTimeTable()
        XCTAssertEqual("E", timeTable["03:04"])
        XCTAssertEqual("U", timeTable["03:00"])

    }

    func testCalcoloOreResidue() {
        let timeCounter = TimeCounter()
        timeCounter.entrata("04:05")
        timeCounter.uscita("08:00")
        XCTAssertEqual("03:55", timeCounter.getOreTotali())
    }

}