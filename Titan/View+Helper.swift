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
// MARK: - Shareable
// Easily to get ViewID and XIB file
protocol Shareable {
    
    // View ID
    static var viewID: String {get}
    
    // XIB - init from viewID
    static func xib() -> NSNib?
}


//
// MARK: - Shareable
extension NSView: Shareable {
    static var viewID: String {
        get {
            return String(describing: self)
        }
    }
    
    static func xib() -> NSNib? {
        return NSNib(nibNamed: self.viewID, bundle: nil)
    }
}
