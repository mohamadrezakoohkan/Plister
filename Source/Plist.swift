//
//  Plist.swift
//  Water
//
//  Created by Mohammad reza Koohkan on 2/6/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit.UIApplication
#elseif os(tvOS)
import UIKit.UIApplication
#elseif os(macOS)
import AppKit.NSApplication
#endif

/// Property list, A file with the default settings.
///
/// In the macOS, iOS, NeXTSTEP, and GNUstep programming frameworks, property list files are files that store serialized objects.
///
/// Property list files use the filename extension .plist, and thus are often referred to as p-list files.
///
/// [Wikipedia](https://en.wikipedia.org/wiki/Property_list)
///
///     let plist = Plist(withNameAtDocumentDirectory: "Plister")
///     plist.set(2020,for: "new.year")
///     plist.get("new.year")
///     // Output: 2020
///
///
///
///
public class Plist {
    
    /// Default plist file extension.
    ///
    internal static let typ = ".plist"
    
    /// Default folder name which stores plist. you can change it
    ///
    public static let folderName: String = "Plist"
    
    /// Url of plist wether inside a bundle or document directory
    ///
    public let url: URL
    
    /// Return result of encryption object, if encryption was `nil` result will be false
    ///
    public var encrypted: Bool { return self.encryption != nil }
    
    /// An **AES** object that used to encrypt and decrypt properties value
    ///
    public private(set) var encryption: AES? = nil
    
    /// Original dictionary Get-only to plist.
    ///
    /// Modification occurs on `cache` property first, then at the end or on your command
    /// `cache` writes to plist and dictionary will updated.
    ///
    public var dictionary: NSMutableDictionary? {
        return NSMutableDictionary(contentsOf: self.url)
    }
    
    /// Lazy initialized copy of `dicitonary` property which can be used to read and write
    /// at last on `willTerminateNotification` and `didEnterBackgroundNotification`
    /// cache will write to document directory and `dictionary` property will updated.
    ///
    public lazy var cache: NSMutableDictionary? = {
        return self.dictionary
    }()
    
    /// Property list size with byte described
    ///
    public var volume: Int64 {
        return self.url.fileSize
    }
    
    /// Property list size including **Binary prefix**
    ///
    public var size: String {
        return self.url.fileSizeString
    }
    
    /// Property list file name
    ///
    public var fileName: String {
        return self.url.lastPathComponent
    }
    
    /// Property list name
    ///
    public var name: String {
        return self.fileName.replace(Plist.typ, with: .empty)
    }
    
    /// Observer for `willTerminateNotification` and `didEnterBackgroundNotification` to
    /// save dictionary while application goes to inactive state. this approach will reduce
    /// Time complexity from **O(n^3)** to **O(logn)** and battry charge, for testing this
    /// call `testPerformance` inside `PlistTest` target.
    ///
    internal func observer() {
        #if os(iOS)
        self.setObserver(forNotification: UIApplication.willTerminateNotification,
                         UIApplication.didEnterBackgroundNotification)
        #elseif os(tvOS)
        self.setObserver(forNotification: UIApplication.willTerminateNotification,
                         UIApplication.didEnterBackgroundNotification)
        #elseif os(macOS)
        self.setObserver(forNotification: NSApplication.willTerminateNotification,
                         NSApplication.didHideNotification)
        #endif
    }
    
    
    /// NotificationCenter will observer for given notifications
    ///
    internal func setObserver(forNotification notifs: NSNotification.Name...) {
        notifs.forEach {
            NotificationCenter.default.addObserver(self, selector: #selector(self.save), name: $0, object: nil)
        }
    }
    
    /// Helper for accessing path to given file when `url` is not available.
    ///
    /// - Parameters:
    ///   - name: Plist name at document directory.
    ///
    ///
    internal static func address(name: String) -> String {
        return FileManager.documentDirectory.path(to: folderName,name + typ)
    }
    
    /// Write dictionary to document directory, no need to call this method **Plist**
    /// will do it when needed.
    ///
    @objc public func save() {
        self.cache?.write(to: self.url,atomically: true)
        self.cache = self.dictionary
    }
    
    /// Initialize a plist object with given url inside main bundle.
    ///
    /// every file inside a bundle is read-only so you can only read object attributes.
    ///
    ///
    ///     let url = Bundle.main.url(forResource: "Info", withExtension: "plist")
    ///     let plist = Plist(mainBundleUrl: url!)
    ///
    ///
    /// - Parameters:
    ///   - url: Url to plist inside a bundle.
    ///
    ///
    public init(insideBundleUrl url: URL) {
        self.url = url
        self.observer()
    }
    
    /// Initialize a plist object with given name and store plist file inside
    /// document directory then you can read and write.
    ///
    /// If there is a plist which has same name this method only retrive
    /// that plist without any change to that file.
    ///
    ///     let name = "Client"
    ///     let plist = Plist(withNameAtDocumentDirectory: name)
    ///
    /// - Parameters:
    ///   - name: Name of given plist file.
    ///   - folder: Folder inside document directory, if there was not a folder,
    ///    **Plister** created a folder with given name
    ///
    public init(withNameAtDocumentDirectory name: String,folderName folder: String = Plist.folderName) {
        let path = Plist.address(name: name)
        FileManager.default.folder(name: folder)
        FileManager.default.fileExists(atPath: path)
            ? (self.url = .init(fileURLWithPath: path))
            : (self.url = .createPlist(at: Plist.folderName, name: name, of: Plist.typ))
        self.observer()
    }
    
    
    /// Initialize a **encrypted** value plist object with given name and store plist file inside
    /// document directory then you can read and write. If there is a plist which
    /// has same name this method only retrive that plist without any change to that file.
    ///
    ///     let name = "Wallet"
    ///     let plist = Plist(withNameAtDocumentDirectory: name)
    ///
    /// - Parameters:
    ///   - name: Name of given plist file.
    ///   - folder: Folder inside document directory, if there was not a folder,
    ///    **Plister** created a folder with given name
    ///   - encryption: an AES object to encrypt and decrypt data.
    ///
    public convenience init(withNameAtDocumentDirectory name: String, folderName folder: String = Plist.folderName, encryption: AES) {
        self.init(withNameAtDocumentDirectory: name, folderName: folder)
        self.encryption = encryption
    }
    
    /// Delete given plist from **DocumentDirectory** and **Deinitialize** the object at
    /// same time.
    ///
    ///     let settings = Plist(withNameAtDocumentDirectory: "Settings")
    ///     Plist.delete(&settings)
    ///     print("Settings: \(settings)")
    ///     // Settings: nil
    ///
    ///
    /// - Parameters:
    ///   - plist: Plist object as a refrence of plist object to remove from memory and document directory
    ///
    ///
    public static func delete(_ plist: inout Plist?) {
        guard let url = plist?.url else { Error.deleted(at: plist?.url).raise(); return }
        do { try FileManager.default.removeItem(at: url) }
        catch { Error.filemanagerRemove(with: error).raise() }
        plist = nil
    }
    
}



