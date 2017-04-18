
//
//  ApplicationManager.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/4/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation

open class ApplicationManager: NSObject {
    
    //
    // MARK: - Variable
    public static let sharedInstance = ApplicationManager()
    
    // Global Date formatter
    lazy var globalDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        dateFormatter.locale = NSLocale.init(localeIdentifier: "en_US_POSIX") as Locale!
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'zzz'Z'"
        return dateFormatter
    }()
    
    //
    // MARK: Public
    
    /// SDK
    public func initAllSDKs() {
        
        // Fabric
        self.initFabric()
    }
    
    /// Common
    public func initCommon(window: NSWindow?) {
        
        // Logger
        self.initLogger()
        
        // Global Appearance
        self.initGlobalAppearance()
        
        // App Version Checker
        _ = AppVersionManager.sharedInstance
    }
    
    /// Default data
    public func importDefaultDataIfNeed() {
        
        let userDefault = UserDefaults.standard
        let isFirstTime = userDefault.objectForKey(.isFirstTime) as? Bool
        guard isFirstTime == nil else {return}
        
        // Import built-in quoration into realm database
        self.importQuotation()
        
        // Save
        userDefault.setObject(true, for: .isFirstTime)
        userDefault.synchronize()
    }
}


//
// MARK: - Private
extension ApplicationManager {
    
    // Logger
    fileprivate func initGlobalAppearance() {
        
    }
}

// MARK:
// MARK: Fabric
extension ApplicationManager {
    fileprivate func initFabric() {
        
    }
}

// MARK:
// MARK: Logger
extension ApplicationManager {
    fileprivate func initLogger() {
        Logger.initLogger()
    }
}

//
// MARK: - Default Data
extension ApplicationManager {
    fileprivate func importQuotation() {
        InspiredQuotation.importDefaultQuotation()
    }
}
