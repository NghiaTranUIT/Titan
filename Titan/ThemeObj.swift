//
//  ThemeObj.swift
//  Titan
//
//  Created by Nghia Tran on 12/3/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ObjectMapper
import DynamicColor

class ThemeObj: BaseModel {
    
    //
    // MARK: - Variable
    var name: String!
    
    // App
    var primaryMainAppColor: NSColor!
    
    // Text
    var primaryTextColor: NSColor! // Always is White
    var secondaryTextColor: NSColor! // Like gray
    var quaternaryTextColor: NSColor! // heavy gray on black menu
    
    // Menu 
    var primaryMenuColor: NSColor! // Color of menu
    var secondaryMenuColor: NSColor! // Color for LOGO + Top Bar
    var quaternaryMenuColor: NSColor! // Color for side menu (like white-gray)
    
    // Alert
    var errorColor: NSColor!
    var acceptColor: NSColor!
    var alertMenuColor: NSColor!
    
    //
    // MARK: - Singleton
    static let share = ThemeObj.defaultTheme()
}

//
// MARK: - Default theme
extension ThemeObj {
    
    class func defaultTheme() -> ThemeObj {
        
        let theme = ThemeObj()
        
        // Name
        theme.name = "Default"
        
        // Main App
        theme.primaryMainAppColor = NSColor(hexString: "#2ECC71")
        
        // Text
        theme.primaryTextColor = NSColor(hexString: "#22272A")
        theme.secondaryTextColor = NSColor(hexString: "#B9B9B9")
        theme.quaternaryTextColor = NSColor(hexString: "#7A7D86")
        
        // Menu
        theme.primaryMenuColor = NSColor(hexString: "#31383E")
        theme.secondaryMenuColor = NSColor(hexString: "#22272A")
        theme.quaternaryMenuColor = NSColor(hexString: "#F1F1F1")
        
        // Alert
        theme.errorColor = NSColor(hexString: "#EE5B5B")
        theme.acceptColor = NSColor(hexString: "#00AEDE")
        theme.alertMenuColor = NSColor(hexString: "#FFFAE7")
        
        return theme
    }
}
 
