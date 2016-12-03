//
//  NSView+BackgroundColor.swift
//  Titan
//
//  Created by Nghia Tran on 12/3/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import Cocoa


//
// MARK: - Background Color
extension NSView {
    
    /// Background color
    /// Set wantsLayer = true for layer-backed
    var backgroundColor: NSColor? {
        get {
            guard let color = self.layer?.backgroundColor else {
                return nil
            }
            
            return NSColor(cgColor: color)
        }
        set {
            self.wantsLayer = true
            self.layer?.backgroundColor = newValue?.cgColor
        }
    }
}
