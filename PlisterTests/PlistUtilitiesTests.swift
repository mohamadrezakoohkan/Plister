//
//  PlistUtilitiesTests.swift
//  PlisterTests
//
//  Created by Mohammad reza Koohkan on 8/10/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import XCTest
@testable import Plister

class PlistUtilitiesTests: XCTestCase {

    func testUrlPath() {
        let url = URL(string: "default")
        let path = url?.path(to: "shit","is","happening") ?? ""
        PAssertTrue(path == "default/shit/is/happening" )
    }
    
    func testCombination() {
        let rhs = URL(string: "right/")!
        let lhs = "left"
        let combine = (rhs + lhs) + "amazing"
        PAssertTrue(combine == URL(string: "right/left/amazing")!)

    }
    
    func testWriteDict() {
        let fileName = "writeTest.txt"
        let fileUrl = FileManager.documentDirectory + fileName
        fileUrl.writeDictionary(withKey: "write.key")
        let retrive: URL = .init(fileURLWithPath: fileUrl.path)
        PAssertTrue(FileManager.default.fileExists(atPath: retrive.path))
    }
    
    func testSize() {
        let posibilityRange: ClosedRange<Int64> = 175...185
        let plist = Plist(withNameAtDocumentDirectory: "sizeTest")
        plist.remove(Bundle.main.bundleIdentifier ?? "com.applecode.library.Plister")
        plist.save()
        PAssertTrue(posibilityRange.contains(plist.url.fileSize))
    }

    func testJsonSerializationObject() {
        let json = ["mohamad": 22]
        let data = JSONSerialization.data(obj: json)!
        let string = String.init(data: data, encoding: .utf8)
        PAssert(string, "{\n  \"mohamad\" : 22\n}")
    }
    
    func testJsonSerializationData() {
        let json = ["mohamad": 22]
        let collection: [String] = ["ali","ahmad","20"]
        let collectionData = JSONSerialization.data(obj: collection)!
        let data = JSONSerialization.data(obj: json)!
        let objectSerialized = JSONSerialization.object(data: data)! as! [String: Int]
        let jsonSerialized = JSONSerialization.json(data: data)! as! [String: Int]
        let collectionSerialized = JSONSerialization.collection(data: collectionData)! as! [String]
        PAssert(objectSerialized,json)
        PAssert(jsonSerialized,json)
        PAssert(collectionSerialized,collection)
    }
}
