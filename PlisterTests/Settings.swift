//
//  Settings.swift
//  PlisterTests
//
//  Created by Mohammad reza Koohkan on 4/26/1399 AP.
//  Copyright © 1399 AP Apple Code. All rights reserved.
//

import Foundation
import Plister

class Settings: PlistStorage {
    
    static let plist = Plist(withNameAtDocumentDirectory: "SettingsPropertyWrapper")
    static let shared = Settings()
    
    @Plisted(key: "dimension", plist: Settings.plist, defaultValue: nil)
    var dimension: Double?
}
