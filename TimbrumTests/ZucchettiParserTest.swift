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
   
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testParseData(){
        let parser = ZucchettiParser()
        let stringData = "{\"Data\":[[\"2016-03-03\",\"21:17:19\",\"E\",\"\",\"\",\"\"],[\"2016-03-03\",\"21:17:27\",\"U\",\"\",\"\",\"\"],\"tf,CCCCCC,2\"],\"Fields\":[\"DAYSTAMP\",\"TIMETIMBR\",\"DIRTIMBR\",\"CAUSETIMBR\",\"TYPETIMBR\",\"IPTIMBR\"]}"
        let data = stringData.dataUsingEncoding(NSUTF8StringEncoding)
        let result = parser.parse(data!)
        XCTAssertEqual("4.30", result)
    }
}