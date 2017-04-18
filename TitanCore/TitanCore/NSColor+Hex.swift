//
//  NSColor+Hex.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/12/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

#if os(iOS) || os(tvOS) || os(watchOS)
    /**
     Extension to manipulate colours easily.
     
     It allows you to work hexadecimal strings and value, HSV and RGB components, derivating colours, and many more...
     */
    public typealias DynamicColor = UIColor
#elseif os(OSX)
    /**
     Extension to manipulate colours easily.
     
     It allows you to work hexadecimal strings and value, HSV and RGB components, derivating colours, and many more...
     */
    public typealias DynamicColor = NSColor
#endif

//
// MARK: - Extension
public extension DynamicColor {
    
    /**
     Creates a color from an hex string (e.g. "#3498db").
     
     If the given hex string is invalid the initialiser will create a black color.
     
     - parameter hexString: A hexa-decimal color string representation.
     */
    public convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner   = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        
        if scanner.scanHexInt32(&color) {
            self.init(hex: color)
        }
        else {
            self.init(hex: 0x000000)
        }
    }

    /**
     Creates a color from an hex integer (e.g. 0x3498db).
     
     - parameter hex: A hexa-decimal UInt32 that represents a color.
     */
    public convenience init(hex: UInt32) {
        let mask = 0x000000FF
        
        let r = Int(hex >> 16) & mask
        let g = Int(hex >> 8) & mask
        let b = Int(hex) & mask
        
        let red   = CGFloat(r) / 255
        let green = CGFloat(g) / 255
        let blue  = CGFloat(b) / 255
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
}
