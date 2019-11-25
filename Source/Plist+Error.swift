//
//  Plist+Error.swift
//  Plist
//
//  Created by Mohammad reza Koohkan on 5/22/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import Foundation

public extension Plist {
    
    /// A type representing an error value that wont thrown but raise in debugger
    ///
    enum Error {
        
        /// When file not found
        ///
        case notFound(at: URL?)
        
        /// When file already deleted
        ///
        case deleted(at: URL?)
        
        /// When there is a problem with parsing to json
        ///
        case parse(at: URL?)
        
        /// When unknown error occurd by file manger
        ///
        case filemanagerRemove(with: Swift.Error)
        
        /// When AES encryption fail to use given key
        ///
        case aesKeyFail(key: String)
        
        /// When AES encryption fail to use given initial vector
        ///
        case aesInitialVectorFail(iv: String)
        
        /// When AES encryption fail to crypt with status
        ///
        case aesCryptFail(status: Int32)
        
        /// When given data was not in data fromat
        ///
        case noData
        
        /// When given string could not convert to utf8
        ///
        case stringNotInUtf8

        /// Identifier to search in debugger console
        ///
        public static let identifier = "$ Plist.error"
        
        
        /// Raise given error in debugger
        ///
        public func raise() {
            DispatchQueue.global().async {
                guard let err = self.errorDescription else {return}
                debugPrint(Plist.Error.identifier,err)
            }
        }
    }
}


extension Plist.Error: Swift.Error, LocalizedError {
    
    /// A localized message describing what error occurred.
    ///
    public var errorDescription: String? {
        switch self {
        case .notFound(let url):
            return "404 Plist notfound at \(url.safePath)"
        case .deleted(let url):
            return "400 Plist already deleted at \(url.safePath)"
        case .parse(let url):
            return "500 Parsing plist at \(url.safePath) made error"
        case .filemanagerRemove(let error):
            return "502 Removing item for file manager throw error \(error.localizedDescription)"
        case .aesKeyFail(let key):
            return "400 Failed to set a key (\(key)) for AES"
        case .aesInitialVectorFail(let iv):
            return "400 Failed to set an initial vector (\(iv)) for AES"
        case .aesCryptFail(let status):
            return "406 Failed to crypt data with Status \(status) for AES"
        case .noData:
            return "403 Given parameter is not a Data"
        case .stringNotInUtf8:
            return "403 Given string could not initialized with data in utf8 format"
            
        }
    }
}
    
internal extension Optional where Wrapped == URL {
    
    /// Unwrap given url to a safe url
    ///
    ///     var url: URL? = nil
    ///     print(url.safePath,url?.path)
    ///     // "nil",nil
    ///
    var safePath: String { return self?.path ?? "nil"}
}
