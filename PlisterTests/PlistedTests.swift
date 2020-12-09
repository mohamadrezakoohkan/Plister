//
//  PlistedTests.swift
//  PlisterTests
//
//  Created by Mohammad reza Koohkan on 4/26/1399 AP.
//  Copyright © 1399 AP Apple Code. All rights reserved.
//

import XCTest
@testable import Plister

class PlistedTests: XCTestCase {

    func testNilProperty() {
        let sut = Settings.shared
        sut.dimension?.delete()
        print(Settings.shared.dimension ?? "nil")
        Settings.shared.dimension = 20
        print(Settings.shared.dimension ?? "nil")
         Settings.shared.dimension = nil
        print(Settings.shared.dimension ?? "nil")
    }
}
