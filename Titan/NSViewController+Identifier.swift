//
//  NSViewController+Identifier.swift
//  Titan
//
//  Created by Nghia Tran on 12/2/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import Cocoa

//
// MARK: - Default Implementation for Identifier
extension NSViewController: Identifier {
    
    
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
