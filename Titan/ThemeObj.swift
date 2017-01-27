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
    dynamic var primaryMainAppColor: String!
    
    // Text
    dynamic var primaryTextColor: String! // Always is White
    dynamic var secondaryTextColor: String! // Like gray
    dynamic var quaternaryTextColor: String! // heavy gray on black menu
    
    // Menu 
    dynamic var primaryMenuColor: String! // Color of menu
    dynamic var secondaryMenuColor: String! // Color for LOGO + Top Bar
    dynamic var quaternaryMenuColor: String! // Color for side menu (like white-gray)
    
    // Alert
    dynamic var errorColor: String!
    dynamic var acceptColor: String!
    dynamic var alertMenuColor: String!
    
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
        theme.primaryMainAppColor = "#1799DD"
        
        // Text
        theme.primaryTextColor = "#606872"
        theme.secondaryTextColor = "#8D9298"
        theme.quaternaryTextColor = "#7A7D86"
        
        // Menu
        theme.primaryMenuColor = "#000000"
        theme.secondaryMenuColor = "#22272A"
        theme.quaternaryMenuColor = "#F1F1F1"
        
        // Alert
        theme.errorColor = "#EE5B5B"
        theme.acceptColor = "#00AEDE"
        theme.alertMenuColor = "#FFFAE7"
        
        return theme
    }
}
 
