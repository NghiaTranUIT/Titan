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
    public static var identifierView: String {
        return String(describing: self)
    }
    
    /// XIB
    public static func xib() -> NSNib? {
        return NSNib(nibNamed: self.identifierView, bundle: nil)
    }
}
