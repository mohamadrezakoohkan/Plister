//
//  String+Operator.swift
//  NavanoApp
//
//  Created by Mohammad reza Koohkan on 5/21/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import Foundation
import CommonCrypto

internal extension String {
    
    static let empty = ""
    
    func replace(_ aString: String,with another: String) -> String {
        return self.replacingOccurrences(of: aString, with: another)
    }
    
    /*
     Truncates the string to the specified length number of characters and appends an optional trailing string if longer.
     - Parameter length: Desired maximum lengths of a string
     - Parameter trailing: A 'String' that will be appended after the truncation.
      
     - Returns: 'String' object.
    */
    func trunc(length: Int, trailing: String = "") -> String {
      return (self.count > length) ? self.prefix(length) + trailing : self
    }
    
    mutating func update(_ aString: String,with another: String) {
        self = self.replace(aString, with: another)
    }
    
    static func - (rhs: String,lhs: String) -> String {
        return rhs.replace(lhs, with: .empty)
    }
}
