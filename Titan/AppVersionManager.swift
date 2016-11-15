//
//  AppVersionManager.swift
//  Titan
//
//  Created by Nghia Tran on 10/14/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

final class AppVersionManager {
    
    //
    // MARK: - Variable
    static let sharedInstance = AppVersionManager()
    
    
    //
    // MARK: - Init
    init() {
        self.setupConfiguration()
    }
}


//
// MARK: - Private
extension AppVersionManager {
    fileprivate func setupConfiguration() {
        
    }
}
