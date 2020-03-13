//
//  PlisterTests.swift
//  PlisterTests
//
//  Created by Mohammad reza Koohkan on 8/10/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//


import XCTest
@testable import Plister

func PAssert<T: Equatable>(_ result: T, _ expected: T) {
    let error = "\n\n @fail Expected \(expected) but got \(result) \n"
    XCTAssert(result == expected, error)
}

func PAssertTrue(_ condition: Bool) {
    let error = "\n\n @fail Expected \(true) but got \(condition) \n"
    XCTAssertTrue(condition, error)
}

func PFail(_ message: String) {
    let error = "\n\n @fail \(message) \n"
    XCTFail(error)
}

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
    
    func testVolume() {
        let expectedVolume: Int64 = 255
        let plist = Plist(withNameAtDocumentDirectory: "Volume")
        plist.set(1, for: "something")
        PAssert(expectedVolume, plist.volume)
    }
    
    func testSize() {
        let expectedSize: String = "253 bytes"
        let plist = Plist(withNameAtDocumentDirectory: "Size")
        plist.set("mohamadreza", for: "name")
        plist.set(0, for: "role")
        PAssert(expectedSize, plist.size)
    }
    
    func testName() {
        let plist = Plist.init(withNameAtDocumentDirectory: "Position")
        PAssert(plist.name, "Position")
    }
    
    func testFileName() {
        let plist = Plist.init(withNameAtDocumentDirectory: "Become-Master")
        PAssertTrue(plist.fileName == "Become-Master.plist")
    }
    
    func testDelete() {
        var plist: Plist? = Plist.init(withNameAtDocumentDirectory: "Deletable")
        Plist.delete(&plist)
        let sandbox = FileManager.documentDirectory
        let plistAddress = (sandbox + Plist.folderName) + "Deletable.plist"
        let existance = FileManager.default.fileExists(atPath: plistAddress.path)
        let deinited = plist == nil
        PAssertTrue(!existance && deinited)
    }
    
    func testGetSet() {
        plist.set("Some data", for: "test.set")
        let value = plist.get("test.set") as? String
        PAssert(value,"Some data")
    }
    
    func testClean() {
        plist.set(true, for: "test.clean")
        plist.clean()
        let value = plist.get("test.clean") as? Bool
        PAssert(value, nil)
    }
    
    func testRemove() {
        plist.set(100, for: "test.remove")
        plist.remove("test.remove")
        let value = plist.get("test.remove") as? Int
        PAssert(value, nil)
    }
    
    func testBool() {
        self.plist.set(true, for: "bool.test")
        PAssert(self.plist.bool("bool.test"),true)
    }
    
    func testInt() {
        self.plist.set(100, for: "int.test")
        PAssert(self.plist.int("int.test"),100)
    }
    
    func testDouble() {
        self.plist.set(Double.pi, for: "double.test")
        PAssert(self.plist.double("double.test"),Double.pi)
    }
    
    func testString() {
        self.plist.set("Hello", for: "string.test")
        PAssert(self.plist.string("string.test"),"Hello")
    }
    
    func testDate() {
        let date = Date()
        self.plist.set(date, for: "date.test")
        PAssert(self.plist.date("date.test"),date)
    }
    
    func testDictionary() {
        self.plist.set(["MohamadReza": "Koohkan"], for: "dictionary.test")
        let dict = self.plist.dictionary("dictionary.test")
        PAssert(dict?["MohamadReza"] as? String,"Koohkan")
        PAssert(dict?.keys.first,"MohamadReza")
    }
    
    func testCollection() {
        self.plist.set(["developer",40,true], for: "collection.test")
        let collection = self.plist.collection("collection.test")
        PAssert(collection?[0] as? String,"developer")
        PAssert(collection?[1] as? Int,40)
        PAssert(collection?[2] as? Bool,true)
    }
    
    func testNil() {
        self.plist.set(true, for: "nil.test")
        let value = self.plist.bool("nil.test")
        PAssert(value,true)
        self.plist.null("nil.test")
        let next = self.plist.bool("nil.test")
        PAssert(next,nil)
    }
    
    func testObject() {
        let json: [String: Any] = ["test.object": "object"]
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            self.plist.set(data, for: "test.object")
            let getData = self.plist.get("test.object") as! Data
            PAssert(data,getData)
        }catch{
            PFail(error.localizedDescription)
        }
    }
}
