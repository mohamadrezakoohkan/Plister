//
//  Plisted.swift
//  Plister
//
//  Created by Mohammad reza Koohkan on 4/26/1399 AP.
//  Copyright © 1399 AP Apple Code. All rights reserved.
//

import Foundation

@propertyWrapper
public struct Plisted<Value> {
    
    public let key: String
    public let plist: Plist
    public let defaultValue: Value
    
    public init(key: String, plist: Plist, defaultValue: Value) {
        self.key = key
        self.plist = plist
        self.defaultValue = defaultValue
    }

    
    public var wrappedValue: Value {
        get { return self.plist.get(self.key) as? Value ?? self.defaultValue }
        set { self.plist.set(newValue, for: self.key) }
    }
}

