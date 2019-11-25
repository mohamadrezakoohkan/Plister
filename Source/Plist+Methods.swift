//
//  Plist+Methods.swift
//  NavanoApp
//
//  Created by Mohammad reza Koohkan on 5/21/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import Foundation

public extension Plist {
    
    /// Return cached plist as a collection of key value pairs
    ///
    /// - returns: A Collection of (key,value)
    ///
    func asCollection() -> [NSDictionary.Element] {
        var result: [NSDictionary.Element] = []
        self.cache?.forEach { result.append($0)  }
        return result
    }
    
    /// Sets the value of the specified key to the specified value.
    ///
    ///
    /// If plist encryption enabled, **rawValue** will encrypted with AES algorithm.
    /// and save to plist for given key.
    ///
    ///     let plist = Plist(withNameAtDocumentDirectory: "Information")
    ///     let key = "didUserSignedIn"
    ///     plist.set(true, for: key)
    ///     // Sets true value for didUserSignedIn key
    ///     plist.get(key)
    ///     // result will be true
    ///
    /// - Parameters:
    ///   - rawValue: The value for the property identified by key.
    ///   - key: The name of one of the receiver's properties.
    ///
    func set(_ rawValue: Any?,for key: String) {
        let value = self.encrypted ? self.encrypt(rawValue) : rawValue
        guard let dict = self.cache else { Error.parse(at: url).raise(); return }
        dict.setValue(value, forKey: key);
    }
    
    /// Returns the value for the property identified by a given key.
    ///
    /// If plist encryption enabled, value for given key is represented
    /// as **decrypted** Data that contains String, for better **get** use default methods to
    /// get value as bool,int,string,float,double,json,collection.
    ///
    ///
    /// - Parameters:
    ///   - key: The name of one of the receiver's properties.
    ///
    func get(_ key: String) -> Any? {
        guard let dict = self.cache else { Error.parse(at: url).raise(); return nil}
        let value = dict.value(forKey: key)
        return self.encrypted ? self.decrypt(value as? Data) : value
    }
    
    /// Overwrite a clean dictionary at plist url
    ///
    func clean() {
        self.url.writeDictionary(withKey: self.fileName)
        self.cache = self.dictionary
    }
    
    /// Remove given tuple keys from plist
    ///
    func remove(_ keys: String...) {
        keys.forEach { self.cache?.removeObject(forKey: $0) }
    }
    
    
    /// Remove given collection keys from plist
    ///
    func remove(keys collection: [String]) {
        collection.forEach { self.cache?.removeObject(forKey: $0) }
    }
    
    /// Returns **Bool** value for the property identified by a given key.
    ///
    /// ## Encryption
    /// If plist encryption enabled, the result will decrypted and translate to **Bool** type with most accurate performance.
    ///
    /// - Parameters:
    ///   - key: The name of one of the receiver's properties.
    ///
    func bool(_ key: String) -> Bool? {
        return self.encrypted ? self.decryptedBool(decryptedData: self.get(key)) : self.get(key) as? Bool
    }
    
    
    /// Returns **Int** value for the property identified by a given key.
    ///
    /// ## Encryption
    /// If plist encryption enabled, the result will decrypted and translate to **Int** type with most accurate performance.
    ///
    /// - Parameters:
    ///   - key: The name of one of the receiver's properties.
    ///
    func int(_ key: String) -> Int? {
        return self.encrypted ? self.decryptedInt(decryptedData: self.get(key)) : self.get(key) as? Int
    }
    
    /// Returns **Double** value for the property identified by a given key.
    ///
    /// ## Encryption
    /// If plist encryption enabled, the result will decrypted and translate to **Double** type with most accurate performance.
    ///
    /// - Parameters:
    ///   - key: The name of one of the receiver's properties.
    ///
    func double(_ key: String) -> Double? {
        return self.encrypted ? self.decryptedDouble(decryptedData: self.get(key)) : self.get(key) as? Double
    }
    
    /// Returns **Float** value for the property identified by a given key.
    ///
    /// ## Encryption
    /// If plist encryption enabled, the result will decrypted and translate to **Float** type with most accurate performance.
    ///
    /// - Parameters:
    ///   - key: The name of one of the receiver's properties.
    ///
    func float(_ key: String) -> Float? {
        return self.encrypted ? self.decryptedFloat(decryptedData: self.get(key)) : self.get(key) as? Float
    }
    
    /// Returns **String** value for the property identified by a given key.
    ///
    /// ## Encryption
    /// If plist encryption enabled, the result will decrypted and translate to **String** type with most accurate performance.
    ///
    /// - Parameters:
    ///   - key: The name of one of the receiver's properties.
    ///
    func string(_ key: String) -> String? {
        return self.encrypted ? self.decryptedString(decryptedData: self.get(key)) : self.get(key) as? String
    }
    
    /// Returns **Dictionary** value for the property identified by a given key.
    ///
    /// ## Encryption
    /// If plist encryption enabled, the result will decrypted and translate to **Dictionary** type with most accurate performance.
    ///
    /// - Parameters:
    ///   - key: The name of one of the receiver's properties.
    ///
    func dictionary(_ key: String) -> [String: Any]? {
        return self.encrypted ? self.decryptedDictionary(decryptedData: self.get(key)) : self.get(key) as? [String: Any]
    }
    
    /// Returns **Collection** value for the property identified by a given key.
    ///
    /// ## Encryption
    /// If plist encryption enabled, the result will decrypted and translate to **Collection** type with most accurate performance.
    ///
    /// - Parameters:
    ///   - key: The name of one of the receiver's properties.
    ///
    func collection(_ key: String) -> [Any]? {
        return self.encrypted ? self.decryptedCollection(decryptedData: self.get(key)) : self.get(key) as? [Any]
    }

    /// Returns **Date** value for the property identified by a given key.
    ///
    /// ## Encryption
    /// If plist encryption enabled, the result will decrypted in **TimeInterval** format and translate to **Date** type
    /// with most accurate performance.
    ///
    /// - Parameters:
    ///   - key: The name of one of the receiver's properties.
    ///
    func date(_ key: String) -> Date? {
        return self.encrypted ? self.decryptedDate(decryptedData: self.get(key)) : self.get(key) as? Date
    }
    
    
    /// Returns **Data** value for the property identified by a given key.
    ///
    /// ## Encryption
    /// If plist encryption enabled, the result will decrypted in **TimeInterval** format and translate to **Date** type
    /// with most accurate performance.
    ///
    /// - Parameters:
    ///   - key: The name of one of the receiver's properties.
    ///
    func data(_ key: String) -> Data? {
        return self.get(key) as? Data
    }
    
    
    /// Remove value for given key.
    ///
    /// - Parameters:
    ///   - key: The name of one of the receiver's properties.
    ///
    func null(_ key: String) {
        self.set(nil, for: key)
    }
    
}

