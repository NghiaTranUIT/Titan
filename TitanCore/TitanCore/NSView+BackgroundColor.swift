//
//  NSView+BackgroundColor.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/12/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import Cocoa

//
// MARK: - Background Color
public extension NSView {
    
    /// Background color
    /// Set wantsLayer = true for layer-backed
   public var backgroundColor: NSColor? {
        get {
            guard let color = self.layer?.backgroundColor else {return nil}
            return NSColor(cgColor: color)
        }
        set {
            self.wantsLayer = true
            self.layer?.backgroundColor = newValue?.cgColor
        }
    }
}
