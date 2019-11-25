//
//  NSKeyed+OSHandler.swift
//  NavanoApp
//
//  Created by Mohammad reza Koohkan on 5/21/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import Foundation

// MARK: - No test

internal extension JSONSerialization {
    
    static func data(obj object: Any) -> Data? {
        do { return try data(withJSONObject: object, options: .prettyPrinted) }
        catch { print(error.localizedDescription); return nil }
    }
    
    static func object(data: Data) -> Any? {
        do { return try jsonObject(with: data, options: .allowFragments) }
        catch { print(error.localizedDescription); return nil }
    }
  
    static func json(data: Data) -> [String: Any]? {
        return JSONSerialization.object(data: data) as? [String: Any]
    }
    
    static func collection(data: Data) -> [Any]? {
        return JSONSerialization.object(data: data) as? [Any]
    }
}
