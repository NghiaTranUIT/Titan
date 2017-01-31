//
//  AppPreferences.swift
//  Titan
//
//  Created by Nghia Tran on 1/31/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation

class AppPreferences {
    
    //
    // MARK: - Share
    static let shared = AppPreferences()
    
    //
    // MARK: - Variable
    
    // User default
    fileprivate var defaults = UserDefaults.standard
    
    // Main window frame
    var mainWindowFrame: NSRect {
        set {
            let valueStr = NSStringFromRect(newValue)
            self.defaults.setObject(valueStr, for: .mainWindowFrame)
            self.defaults.synchronize()
        }
        get {
            guard let valueStr = self.defaults.objectForKey(.mainWindowFrame) as? String else {
                return Constants.Preference.MainWindowFrame
            }
            return NSRectFromString(valueStr)
        }
    }
    
    // Divider position of split view
    var dividerPosition: CGFloat {
        set {
            self.defaults.setObject(newValue, for: .dividerPosition)
            self.defaults.synchronize()
        }
        get {
            guard let value = self.defaults.objectForKey(.dividerPosition) as? CGFloat else {
                return Constants.Preference.DividerPosition
            }
            return value
        }
    }
}
