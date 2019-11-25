//
//  PlisterEncryptedTests.swift
//  PlisterTests
//
//  Created by Mohammad reza Koohkan on 8/26/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//


import XCTest
@testable import Plister
    
class PlisterEncryptedTests: XCTestCase {
    
    let plist = Plist(withNameAtDocumentDirectory: "Crypt", encryption: .default)

    let collection = (data: ["Swift","Obj-C"],key: "Collection")
    let json = (data: ["mohamadreza": "developer"],key: "Json")
    let bool = (data: true,key: "Bool")
    let int = (data: 1239,key: "Int")
    let double = (data: Double(12.3912311),key: "Double")
    let float = (data: Float(3.14),key: "Float")
    let string = (data:"Hello world!",key: "String")
    let date = (data: Date(),key: "Date")

    let byteMultiplier16 = (data: "01234567890123456",range: 0...3)
    let byteMultiplier32 = (data: "0123456789012345601234567890123456",range: 0...3)

    
    override func tearDown() {
        self.plist.save()
    }
    
    func testLargeData() {
        let input = self.byteMultiplier16
        var string = ""
        input.range.forEach { _ in string += input.data }
        self.plist.set(string, for: "LargeData")
    }
    
    func encryptAndDecrypt(_ value: Any?) -> Data? {
        let encryptedData = self.plist.encrypt(value)
        return self.plist.decrypt(encryptedData)
    }

    func testJsonDecrypt() {
        let input = self.json
        let decryptedData = self.encryptAndDecrypt(input.data)
        let result = self.plist.decryptedDictionary(decryptedData: decryptedData)
        XCTAssertEqual(result as? [String: String],input.data)
    }
    
    func testJsonSetEncrypt() {
        let input = self.json
        self.plist.set(input.data, for: input.key)
        XCTAssertEqual(self.plist.dictionary(input.key) as? [String: String],input.data)
    }
    
    func testCollectionDecrypt() {
        let input = self.collection
        let decryptedData = self.encryptAndDecrypt(input.data)
        let result = self.plist.decryptedCollection(decryptedData: decryptedData)
        XCTAssertEqual(result as? [String],input.data)
    }
    
    func testCollectionSetEncrypt() {
        let input = self.collection
        self.plist.set(input.data, for: input.key)
        XCTAssertEqual(self.plist.collection(input.key) as? [String],input.data)
    }
    
    func testStringDecrypt() {
        let input = self.string
        let decryptedData = self.encryptAndDecrypt(input.data)
        let result = self.plist.decryptedString(decryptedData: decryptedData)
        XCTAssertEqual(result,input.data)
    }
    
    func testStringSetEncrypt() {
         let input = self.string
         self.plist.set(input.data, for: input.key)
         XCTAssertEqual(self.plist.string(input.key),input.data)
     }
    
    func testBoolDecrypt() {
        let input = self.bool
        let decryptedData = self.encryptAndDecrypt(input.data)
        let result = self.plist.decryptedBool(decryptedData: decryptedData)
        XCTAssertEqual(result,input.data)
    }
    
    func testBoolSetEncrypt() {
        let input = self.bool
        self.plist.set(input.data, for: input.key)
        XCTAssertEqual(self.plist.bool(input.key),input.data)
    }
    
    func testIntDecrypt() {
        let input = self.int
        let decryptedData = self.encryptAndDecrypt(input.data)
        let result = self.plist.decryptedInt(decryptedData: decryptedData)
        XCTAssertEqual(result,input.data)
    }
    
    func testIntSetEncrypt() {
        let input = self.int
        self.plist.set(input.data, for: input.key)
        XCTAssertEqual(self.plist.int(input.key),input.data)
    }
    
    func testDoubleDecrypt() {
        let input = self.double
        let decryptedData = self.encryptAndDecrypt(input.data)
        let result = self.plist.decryptedDouble(decryptedData: decryptedData)
        XCTAssertEqual(result,input.data)
    }
    
    func testDoubleSetEncrypt() {
        let input = self.double
        self.plist.set(input.data, for: input.key)
        XCTAssertEqual(self.plist.double(input.key),input.data)
    }
    
    func testFloatDecrypt() {
        let input = self.float
        let decryptedData = self.encryptAndDecrypt(input.data)
        let result = self.plist.decryptedFloat(decryptedData: decryptedData)
        XCTAssertEqual(result,input.data)
    }
    
    func testFloatSetEncrypt() {
        let input = self.float
        self.plist.set(input.data, for: input.key)
        XCTAssertEqual(self.plist.float(input.key),input.data)
    }
    
    func testDateDecrypt() {
        let input = self.date
        let decryptedData = self.encryptAndDecrypt(input.data)
        let result = self.plist.decryptedDate(decryptedData: decryptedData)
        XCTAssertEqual(result,input.data)
    }
    
    func testDateEncrypt() {
        let input = self.date
        self.plist.set(input.data, for: input.key)
        XCTAssertEqual(self.plist.date(input.key),input.data)
    }
    
}

