//
//  User.swift
//  PlisterTests
//
//  Created by Mohammad reza Koohkan on 2/21/1399 AP.
//  Copyright © 1399 AP Apple Code. All rights reserved.
//

import Foundation

struct User: Codable, Equatable {
    
    var uuid: String = UUID().uuidString
    var name: String
    var age: Int
    var createdAt: Date    
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
}
