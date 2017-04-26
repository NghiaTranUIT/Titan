//
//  View+Identity.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/12/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation

public enum BundleType {
    case app
    case core
    
    public var bundleName: String {
        switch self {
        case .app:
            return "com.fe.nghiatran.TitanMacOS"
        case .core:
            return "com.fe.nghiatran.TitanCore"
        }
    }
}

//
// MARK: - Identifier
// Easily to get ViewID and XIB file
public protocol Identifier {
    
    /// ID view
    static var identifierView: String {get}
    
    /// XIB - init XIB from identifierView
    static func xib(with bundleType: BundleType) -> NSNib?
}


//
// MARK: - Default Extension
public extension Identifier {
    
    /// ID View
    static var identifierView: String {
        get {
            return String(describing: self)
        }
    }
    
    /// XIB
    static func xib(with bundleType: BundleType) -> NSNib? {
        let bundle = Bundle(identifier: bundleType.bundleName)
        return NSNib(nibNamed: self.identifierView, bundle: bundle)
    }
}

//
// MARK: - Default Implementation for Identifier
extension NSView: Identifier {}
extension NSMenu: Identifier {}

