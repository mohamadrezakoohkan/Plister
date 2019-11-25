//
//  FileManager+DocumentDir.swift
//  NavanoApp
//
//  Created by Mohammad reza Koohkan on 5/21/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import Foundation


internal extension FileManager {
    
    static var documentDirectory: URL = {
        let dirs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = dirs.first!
        return path
    }()
    
    func folder(name: String) {
        var isDir: ObjCBool = false
        let location = (FileManager.documentDirectory + name).path
        guard !self.fileExists(atPath: location, isDirectory: &isDir) else { return }
        do { try self.createDirectory(atPath: location, withIntermediateDirectories: true) }
        catch { print("#P Creating Folder made ERROR: \n \(error.localizedDescription)")}
    }
}
