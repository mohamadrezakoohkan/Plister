//
//  PlisterStringTests.swift
//  PlisterTests
//
//  Created by Mohammad reza Koohkan on 8/10/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import XCTest
@testable import Plister

class PlisterStringTest: XCTestCase {
    
    func testEmptyString() {
        let str = ""
        XCTAssertTrue(str == .empty)
    }
    
    func testReplaceString() {
        let raw = "This is a UnitTest"
        let modified = raw.replace("UnitTest", with: "UITest")
        XCTAssertTrue(modified == "This is a UITest")
    }
    
    func testTruncString() {
        let text = "It is a sentence of 32 character"
        let limited = text.trunc(length: 16)
        XCTAssertEqual(limited.count, 16)
    }
    
    func testUpdateString() {
        var raw = "This is a UnitTest"
        raw.update("UnitTest", with: "UITest")
        XCTAssertTrue(raw == "This is a UITest")
    }
    
    func testOperatorString() {
        let raw = "This is a UnitTest"
        let modified = raw - "UnitTest"
        XCTAssertTrue(modified == "This is a ")
    }
}
