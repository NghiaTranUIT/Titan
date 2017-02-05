//
//  Xib+Helper.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import Cocoa

//
// MARK: - Identifier
// Easily to get ViewID and XIB file
protocol Identifier {
    
    /// ID view
    static var identifierView: String {get}
    
    /// XIB - init XIB from identifierView
    static func xib() -> NSNib?
}


//
// MARK: - Default Extension
extension Identifier {
    
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

