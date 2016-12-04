//
//  NSButton+TextColor.swift
//  Titan
//
//  Created by Nghia Tran on 12/3/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import Cocoa

//
// MARK: - NSButtom + TextColor
extension NSButton {
    
    /// Support Text color for NSButton
    var textColor: NSColor? {
        get {
            let count = self.title.characters.count as Int
            return self.attributedTitle.attributes(at: 0, longestEffectiveRange: nil, in: NSRange(location: 0, length: count))[NSForegroundColorAttributeName] as? NSColor
        }
        set {
            // Paragraph
            let count = self.title.characters.count as Int
            var att = self.attributedTitle.attributes(at: 0, longestEffectiveRange: nil, in: NSRange(location: 0, length: count))
            
            // Override color
            att[NSForegroundColorAttributeName] = newValue ?? NSColor.white
            
            // Attribute text
            self.attributedTitle = NSAttributedString(string: self.title, attributes: att)
        }
    }
}
