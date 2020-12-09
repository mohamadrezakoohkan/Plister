//
//  PlistStorage.swift
//  Plister
//
//  Created by Mohammad reza Koohkan on 4/26/1399 AP.
//  Copyright © 1399 AP Apple Code. All rights reserved.
//

import Foundation

public protocol PlistStorage {
    
    /// declare using `let` in class
    static var plist: Plist { get }
    
}
