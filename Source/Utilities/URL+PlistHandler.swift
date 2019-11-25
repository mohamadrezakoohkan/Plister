//
//  URL+PlistHandler.swift
//  NavanoApp
//
//  Created by Mohammad reza Koohkan on 5/21/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import Foundation

internal extension URL {
    
    var attributes: [FileAttributeKey : Any]? {
        do { return try FileManager.default.attributesOfItem(atPath: path) }
        catch { print("FileAttribute error: \(error)"); return nil }
    }
    
    var sizeAttrbute: UInt64 {
        return (self.attributes?[FileAttributeKey.size] as? UInt64) ?? 0
    }
    
    var fileSize: Int64 {
        return Int64(self.sizeAttrbute)
    }
    
    var fileSizeString: String {
        return ByteCountFormatter.string(fromByteCount: self.fileSize, countStyle: .file)
    }
    
    var creationDate: Date? {
        return self.attributes?[.creationDate] as? Date
    }
        
    func path(to routes: String...) -> String {
        return (self + routes.reduce("") { $0 + "/" + $1 }).path
    }
    
    func writeDictionary(withKey key: String) {
        let root = Bundle.main.bundleIdentifier ?? "com.applecode.library.Plister"
        let dictionary: NSMutableDictionary = [root: key]
        dictionary.write(to: self, atomically: true)
    }
    
    func updateDictionary() {
        let dictionary = NSMutableDictionary(contentsOf: self)
        dictionary?.write(to: self, atomically: true)
    }
    
    static func + (rhs: URL,lhs: String) -> URL {
        return rhs.appendingPathComponent(lhs)
    }
    
    static func createPlist(at folder: String = "",name: String,of type: String) -> URL {
        let plist = (FileManager.documentDirectory + folder) + name.appending(type)
        plist.writeDictionary(withKey: name)
        return plist
    }

    
}
