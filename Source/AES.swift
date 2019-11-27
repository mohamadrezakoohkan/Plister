//
//  AES.swift
//  Plister
//
//  Created by Mohammad reza Koohkan on 8/12/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import Foundation
import CommonCrypto

/// Advanced Encryption Standard (AES)
///
/// For testing purpose created a static instance called `default` which takes a key of 16 or 32 characters and an iv of 16 characters
/// for **Production** try to create your own AES object
///
///     var aes: AES? = {
///       var key128 = "1qaz2wsx3edc4rfv"
///       let iv =  "5tgb6yhn7ujm8ikl"
///       return AES(key: key128, iv: iv)
///     }()
///
///
public struct AES {
    
    /// Data representing key in utf8 format
    ///
    public let key: Data
    
    /// Data representing iv in utf8 format
    ///
    public let iv: Data
    
    /// Advanced Encryption Standard, 128-bit block
    ///
    public var algorithm: CCAlgorithm { CCAlgorithm(kCCAlgorithmAES) }
    
    /// Perform PKCS7 padding.
    ///
    /// Electronic code book mode, default is CBC.
    ///
    public var options: CCOptions { CCOptions(kCCOptionPKCS7Padding) }
    
    /// Encrypt option
    ///
    public var encOption: CCOptions { CCOperation(kCCEncrypt) }
    
    /// Decrypt option
    ///
    public var decOption: CCOptions { CCOperation(kCCDecrypt) }
    
    /// Status where operation completed normally
    ///
    public var successStatus: UInt32 { UInt32(kCCSuccess) }
    
    /// Evaluate a status, with needed status
    ///
    /// - Parameters:
    ///   - current: Input status
    ///   - needed: UInt32 format of a **kCC** status.
    ///
    public func evaluate(_ current: CCCryptorStatus,with needed: UInt32) -> Bool {
        return UInt32(current) == needed
    }
    
    /// Error Class used for AES errors.
    ///
    public typealias error = Plist.Error
        
    /// Default AES object for test purpose
    ///
    ///     public static var `default`: AES = {
    ///         var key128 = "1234567890123456"
    ///         let iv =  "abcdefghijklmnop"
    ///         return AES(key: key128, iv: iv)!
    ///     }()
    ///
    internal static var `default`: AES = {
        var key128 = "1234567890123456"
        let iv =  "abcdefghijklmnop"
        return AES(key: key128, iv: iv)!
    }()
    
    /// Initialize an optional AES object
    ///
    /// Can fail to initalize when key characters was not 16 chars or 32 cars, or initial vector `iv` was not 16 chars.
    ///
    /// - Parameters:
    ///   - key: Key string in 16 or 32 chars.
    ///   - iv: Initial vector in 16 chars.
    ///
    public init?(key: String, iv: String) {
        let isKeyEnough = key.count == kCCKeySizeAES128 || key.count == kCCKeySizeAES256
        let isIvEnough = iv.count == kCCKeySizeAES128
        guard isKeyEnough, let keyData = key.data(using: .utf8) else { error.aesKeyFail(key: key).raise(); return nil }
        guard isIvEnough, let ivData = iv.data(using: .utf8) else { error.aesInitialVectorFail(iv: iv).raise(); return nil }
        self.key = keyData
        self.iv  = ivData
    }
    
    
    /// Encrypt raw data with **kCCEncrypt** option, returns encrypted data
    ///
    /// - Parameters:
    ///   - data: Raw data
    ///
    public func encrypt(data: Data) -> Data? {
        return crypt(data: data, option: self.encOption)
    }
    
    /// Decrypt encrypted data with **kCCDecrypt** option, returns raw data
    ///
    /// - Parameters:
    ///   - data: Encrypted data
    ///
    public func decrypt(data: Data?) -> Data? {
        return crypt(data: data, option: self.decOption)
    }
    
    
    /// Crypt data whether **Encrypted Data** or **Raw Data** with **kCCDecrypt** or **kCCEncrypt** option
    /// and returns data based on requested option
    ///
    /// - Parameters:
    ///   - data: **Encrypted Data** or **Raw Data**
    ///   - option: **kCCDecrypt** or **kCCEncrypt**
    ///
    public func crypt(data: Data?, option: CCOperation) -> Data? {
        
        guard let data = data else { return nil }
        
        let cryptLength = data.count + kCCBlockSizeAES128
        var cryptData   = Data(count: cryptLength)
        let keyLength = key.count
        var bytesLength = Int(0)
        let dataLength = data.count
        
        let status = cryptData.withUnsafeMutableBytes { cryptBytes in
            data.withUnsafeBytes { dataBytes in
                iv.withUnsafeBytes { ivBytes in
                    key.withUnsafeBytes { keyBytes in
                        CCCrypt(option,
                                self.algorithm,
                                self.options,
                                keyBytes.baseAddress,
                                keyLength,
                                ivBytes.baseAddress,
                                dataBytes.baseAddress,
                                dataLength,
                                cryptBytes.baseAddress,
                                cryptLength,
                                &bytesLength)
                    }
                }
            }
        }
        
        guard self.evaluate(status, with: self.successStatus) else { error.aesCryptFail(status: status).raise(); return nil }
        
        cryptData.removeSubrange(bytesLength..<cryptData.count)
        return cryptData
    }
    
    
}

