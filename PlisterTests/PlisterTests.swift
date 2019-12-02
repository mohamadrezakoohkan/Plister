//
//  PlisterTests.swift
//  PlisterTests
//
//  Created by Mohammad reza Koohkan on 8/10/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//


import XCTest
@testable import Plister

class PlisterTests: XCTestCase {
    
    let plist = Plist(withNameAtDocumentDirectory: "Test")
    
    let range = 0...200000
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        self.plist.save()
    }
    
    func testSetPerformance() {
        measure {
            for i in range { self.plist.set(i, for: "\(i).key") }
        }
    }
    
    func testSavePerformance() {
        measure {
            self.plist.save() // for used range
        }
    }
    
    func testGetPerformance() {
        measure {
            for i in range { _ = self.plist.get("\(i).key") }
        }
    }
    
    func testIteratePerformance() {
        measure {
            self.plist.dictionary?.forEach { pair in }
        }
    }
    
    func testRemovePerformance() {
        measure {
            var keys = [String]()
            for i in range { keys.append("\(i).key") }
            self.plist.remove(keys: keys)
        }
    }
    
    func testName() {
        let plist = Plist.init(withNameAtDocumentDirectory: "Position")
        XCTAssertTrue(plist.name == "Position")
    }
    
    func testFileName() {
        let plist = Plist.init(withNameAtDocumentDirectory: "Become-Master")
        XCTAssertTrue(plist.fileName == "Become-Master.plist")
    }
    
    func testDelete() {
        var plist: Plist? = Plist.init(withNameAtDocumentDirectory: "Deletable")
        Plist.delete(&plist)
        let sandbox = FileManager.documentDirectory
        let plistAddress = (sandbox + Plist.folderName) + "Deletable.plist"
        let existance = FileManager.default.fileExists(atPath: plistAddress.path)
        let deinited = plist == nil
        XCTAssertTrue(!existance && deinited)
    }
    
    func testGetSet() {
        plist.set("Some data", for: "test.set")
        let value = plist.get("test.set") as? String
        XCTAssertEqual(value,"Some data")
    }
    
    func testClean() {
        plist.set(true, for: "test.clean")
        plist.clean()
        let value = plist.get("test.clean") as? Bool
        XCTAssertEqual(value, nil)
    }
    
    func testRemove() {
        plist.set(100, for: "test.remove")
        plist.remove("test.remove")
        let value = plist.get("test.remove") as? Int
        XCTAssertEqual(value, nil)
    }
    
    func testBool() {
        self.plist.set(true, for: "bool.test")
        XCTAssertEqual(self.plist.bool("bool.test"),true)
    }
    
    func testInt() {
        self.plist.set(100, for: "int.test")
        XCTAssertEqual(self.plist.int("int.test"),100)
    }
    
    func testDouble() {
        self.plist.set(Double.pi, for: "double.test")
        XCTAssertEqual(self.plist.double("double.test"),Double.pi)
    }
    
    func testString() {
        self.plist.set("Hello", for: "string.test")
        XCTAssertEqual(self.plist.string("string.test"),"Hello")
    }
    
    func testDate() {
        let date = Date()
        self.plist.set(date, for: "date.test")
        XCTAssertEqual(self.plist.date("date.test"),date)
    }
    
    func testDictionary() {
        self.plist.set(["MohamadReza": "Koohkan"], for: "dictionary.test")
        let dict = self.plist.dictionary("dictionary.test")
        XCTAssertEqual(dict?["MohamadReza"] as? String,"Koohkan")
        XCTAssertEqual(dict?.keys.first,"MohamadReza")
    }
    
    func testCollection() {
        self.plist.set(["developer",40,true], for: "collection.test")
        let collection = self.plist.collection("collection.test")
        XCTAssertEqual(collection?[0] as? String,"developer")
        XCTAssertEqual(collection?[1] as? Int,40)
        XCTAssertEqual(collection?[2] as? Bool,true)
    }
    
    func testNil() {
        self.plist.set(true, for: "nil.test")
        let value = self.plist.bool("nil.test")
        XCTAssertEqual(value,true)
        self.plist.null("nil.test")
        let next = self.plist.bool("nil.test")
        XCTAssertEqual(next,nil)
    }
    
    func testObject() {
        let json: [String: Any] = ["test.object": "object"]
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            self.plist.set(data, for: "test.object")
            let getData = self.plist.get("test.object") as! Data
            XCTAssertEqual(data,getData)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func testx() {
        let plist = Plist(withNameAtDocumentDirectory: "Normal")
        let user = User.init(name: "aref")
        plist.set(user, for: "user")
        let plistTop = plist.get("user") as! User
        print(plistTop.name)

    }
    
    
    class User {
        var name: String
        
        init(name: String) {
            self.name = name
        }
    }
    
    
}
