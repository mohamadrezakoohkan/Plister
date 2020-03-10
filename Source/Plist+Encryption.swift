//
//  Plist+Encryption.swift
//  Plister
//
//  Created by Mohammad reza Koohkan on 8/12/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import Foundation

public extension Plist {

    /// Encrypt given value and returns encrypted data
    ///
    /// - Parameters:
    ///   - rawValue: Takes any argument
    ///
    /// Takes any argument and convert to String then create a Data object from string, encoding in **utf8**
    /// and encrypt encoded utf8 to plist encryption algorithm
    ///
    func encrypt(_ rawValue: Any?) -> Data? {
        guard let value = rawValue,
            let cryptor = self.encryption else { return nil }

        guard let string = self.getString(value),
            let data = string.data(using: .utf8) else {
                guard let data = value as? Data else { return nil }
                return cryptor.encrypt(data: data)
        }
        return cryptor.encrypt(data: data)
    }
    
    /// Decrypt given encrypted data and returns decrypted data
    ///
    /// - Parameters:
    ///   - data: Takes an encrypted data
    ///
    func decrypt(_ data: Data?) -> Data? {
        guard let cryptor = self.encryption else { return nil }
        return cryptor.decrypt(data: data)
    }
    
    /// Translate given decrypted data in most accurate performance and returns a **Dictionary**
    ///
    /// - Parameters:
    ///   - decryptedData: Takes a decrypted data
    ///
    func decryptedDictionary(decryptedData rawValue: Any?) -> [String: Any]? {
        guard let dataDecrypted = rawValue as? Data else { Error.noData.raise(); return nil }
        return JSONSerialization.json(data: dataDecrypted)
    }
    
    /// Translate given decrypted data in most accurate performance and returns a **Collection**
    ///
    /// - Parameters:
    ///   - decryptedData: Takes a decrypted data
    ///
    func decryptedCollection(decryptedData rawValue: Any?) -> [Any]? {
         guard let dataDecrypted = rawValue as? Data else { Error.noData.raise(); return nil }
         return JSONSerialization.collection(data: dataDecrypted)
     }
    
    /// Translate given decrypted data in most accurate performance and returns a **String**
    ///
    /// - Parameters:
    ///   - decryptedData: Takes a decrypted data
    ///
    func decryptedString(decryptedData rawValue: Any?) -> String? {
        guard let dataDecrypted = rawValue as? Data else { Error.noData.raise(); return nil }
        guard let string = String(bytes: dataDecrypted, encoding: .utf8) else { Error.stringNotInUtf8.raise(); return nil }
        return string
    }
    
    /// Translate given decrypted data in most accurate performance and returns a **Bool**
    ///
    /// - Parameters:
    ///   - decryptedData: Takes a decrypted data
    ///
    func decryptedBool(decryptedData rawValue: Any?) -> Bool? {
        guard let string = self.decryptedString(decryptedData: rawValue) else { return nil }
        return Bool(string)
    }
    
    /// Translate given decrypted data in most accurate performance and returns a **Int**
    ///
    /// - Parameters:
    ///   - decryptedData: Takes a decrypted data
    ///
    func decryptedInt(decryptedData rawValue: Any?) -> Int? {
        guard let string = self.decryptedString(decryptedData: rawValue) else { return nil }
        return Int(string)
    }
    
    /// Translate given decrypted data in most accurate performance and returns a **Float**
    ///
    /// - Parameters:
    ///   - decryptedData: Takes a decrypted data
    ///
    func decryptedFloat(decryptedData rawValue: Any?) -> Float? {
        guard let string = self.decryptedString(decryptedData: rawValue) else { return nil }
        return Float(string)
    }
    
    /// Translate given decrypted data in most accurate performance and returns a **Double**
    ///
    /// - Parameters:
    ///   - decryptedData: Takes a decrypted data
    ///
    func decryptedDouble(decryptedData rawValue: Any?) -> Double? {
        guard let string = self.decryptedString(decryptedData: rawValue) else { return nil }
        return Double(string)
    }
    
    /// Translate given decrypted data in most accurate performance and returns a **Date**
    ///
    /// - Parameters:
    ///   - decryptedData: Takes a decrypted data
    ///
    func decryptedDate(decryptedData rawValue: Any?) -> Date? {
        guard let string = self.decryptedString(decryptedData: rawValue) else { return nil }
        guard let timestamp = TimeInterval(string) else { return nil }
        return Date(timeIntervalSince1970: timestamp)
    }

    
    /// returns a String describing subject in most accurate value
    ///
    /// - Parameters:
    ///   - subject: Generic subject
    ///
    fileprivate func getString<T>(_ subject: T) -> String? {
        switch subject {
        case is [String: Any], is [T]:
            guard let data = JSONSerialization.data(obj: subject) else { return nil }
            return String(data: data, encoding: .utf8)
        case is String:
            return subject as? String
        case is Date:
            let date = (subject as! Date)
            return String(date.timeIntervalSince1970)
        case is Data:
            return nil
        default:
            return String(describing: subject)
        }
    }
    
    
}
