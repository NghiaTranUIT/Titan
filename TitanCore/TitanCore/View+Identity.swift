//
//  View+Identity.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/12/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation

//
// MARK: - Identifier
// Easily to get ViewID and XIB file
public protocol Identifier {
    
    /// ID view
    static var identifierView: String {get}
    
    /// XIB - init XIB from identifierView
    static func xib() -> NSNib?
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
    static func xib() -> NSNib? {
        return NSNib(nibNamed: self.identifierView, bundle: nil)
    }
}

//
// MARK: - Default Implementation for Identifier
extension NSView: Identifier {}
extension NSMenu: Identifier {}

