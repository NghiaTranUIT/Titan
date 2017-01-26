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
    dynamic var name: String!
    
    // App
    dynamic var primaryMainAppColor: NSColor!
    
    // Text
    dynamic var primaryTextColor: NSColor! // Always is White
    dynamic var secondaryTextColor: NSColor! // Like gray
    dynamic var quaternaryTextColor: NSColor! // heavy gray on black menu
    
    // Menu 
    dynamic var primaryMenuColor: NSColor! // Color of menu
    dynamic var secondaryMenuColor: NSColor! // Color for LOGO + Top Bar
    dynamic var quaternaryMenuColor: NSColor! // Color for side menu (like white-gray)
    
    // Alert
    dynamic var errorColor: NSColor!
    dynamic var acceptColor: NSColor!
    dynamic var alertMenuColor: NSColor!
    
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
        theme.primaryMainAppColor = NSColor(hexString: "#1799DD")
        
        // Text
        theme.primaryTextColor = NSColor(hexString: "#606872")
        theme.secondaryTextColor = NSColor(hexString: "#8D9298")
        theme.quaternaryTextColor = NSColor(hexString: "#7A7D86")
        
        // Menu
        theme.primaryMenuColor = NSColor.white
        theme.secondaryMenuColor = NSColor(hexString: "#22272A")
        theme.quaternaryMenuColor = NSColor(hexString: "#F1F1F1")
        
        // Alert
        theme.errorColor = NSColor(hexString: "#EE5B5B")
        theme.acceptColor = NSColor(hexString: "#00AEDE")
        theme.alertMenuColor = NSColor(hexString: "#FFFAE7")
        
        return theme
    }
}
 
