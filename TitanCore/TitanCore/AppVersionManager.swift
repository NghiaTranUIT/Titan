//
//  AppVersionManager.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/4/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation

//
// MARK: - App Version
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
