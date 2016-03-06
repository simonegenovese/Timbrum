//
//  ZucchettiParserTest.swift
//  Timbrum
//
//  Created by Simone Genovese on 03/03/16.
//  Copyright © 2016 ESTECO. All rights reserved.
//

import XCTest
@testable import Timbrum

class ZucchettiParserTests: XCTestCase {
    
    let parser = ZucchettiParser()
    
    override func setUp() {
        super.setUp()
        

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testParseData() {
        let stringData = "{\"Data\":[[\"04-03-2016\",\"0829\",\"E\",\"\",\" \",\"195.14.103.112\"],[\"04-03-2016\",\"1303\",\"U\",\"\",\" \",\"195.14.103.112\"],[\"04-03-2016\",\"1335\",\"E\",\"\",\" \",\"195.14.103.112\"],[\"04-03-2016\",\"1749\",\"U\",\"\",\" \",\"195.14.103.112\"],\"tf,CCCCCC,4\"],\"Fields\":[\"GIORNO\",\"TIMBRATURA\",\"VERSO\",\"dscausale\",\"Type\",\"IPCLIENT\"]}"
        let data = stringData.dataUsingEncoding(NSUTF8StringEncoding)
        let type = parser.parse(data!)
        XCTAssertEqual("Data", type)
        XCTAssertEqual("4:30", parser.getOreTotali())

    }
}