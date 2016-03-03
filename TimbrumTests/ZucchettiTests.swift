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
    let zucchettiController = ZucchettiController()
    let listener = StubListener()

    override func setUp() {
        super.setUp()
        zucchettiController.addListener(listener)
        zucchettiController.connect("http://zucchetti.toshiro.it/app_dev.php")
        sleep(4)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testZucchettiConnect() {
        let resstr = NSString(data: listener.getData(), encoding: NSUTF8StringEncoding)
        XCTAssertTrue(resstr!.containsString("<title>Symfony - Welcome</title>"))
    }

    func testZucchettiEnter() {
        zucchettiController.enter()
        sleep(4)
        let resstr = NSString(data: listener.getData(), encoding: NSUTF8StringEncoding)
        XCTAssertEqual("Ricevuta timbratura: E\n", resstr)
    }

    func testZucchettiExit() {
        zucchettiController.exit()
        sleep(4)
        let resstr = NSString(data: listener.getData(), encoding: NSUTF8StringEncoding)
        XCTAssertEqual("Ricevuta timbratura: U\n", resstr)
    }
    
    func testZucchettiLog() {
        zucchettiController.loadAccessLog()
        sleep(4)
        let resstr = NSString(data: listener.getData(), encoding: NSUTF8StringEncoding)
        XCTAssertTrue(resstr!.containsString("\"Fields\":[\"DAYSTAMP\",\"TIMETIMBR\",\"DIRTIMBR\",\"CAUSETIMBR\",\"TYPETIMBR\",\"IPTIMBR\"]"))
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
