//
//  ApplicationManager.swift
//  Titan
//
//  Created by Nghia Tran on 10/14/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import Fabric
import Crashlytics

class ApplicationManager: NSObject {
    
    //
    // MARK: - Variable
    static let sharedInstance = ApplicationManager()
    
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
    func initAllSDKs() {
        
        // Fabric
        self.initFabric()
    }
    
    func initCommon(window: NSWindow?) {
        
        // Logger
        self.initLogger()
        
        // Global Appearance
        self.initGlobalAppearance()
        
        // App Version Checker
        _ = AppVersionManager.sharedInstance
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
        Fabric.with([Crashlytics.self])
    }
}

// MARK:
// MARK: Logger
extension ApplicationManager {
    fileprivate func initLogger() {
        Logger.initLogger()
    }
}

