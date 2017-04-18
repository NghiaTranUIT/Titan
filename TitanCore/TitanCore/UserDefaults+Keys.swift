//
//  UserDefaults+Keys.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/4/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation

//
// MARK: - UserDefaults
enum UserDefaultsKey: String {
    
    // Main app
    case isFirstTime
    case mainWindowFrame
    case dividerPosition
    
    // Database
    case defaultLimitQuery
    
    // Add more key here
}

//
// MARK: - UserDefaults + Key
// Warp key as enum
// Easilier to manage
extension UserDefaults {
    
    func objectForKey(_ key: UserDefaultsKey) -> Any? {
        return self.object(forKey: key.rawValue)
    }
    
    func setObject(_ object: Any, for key: UserDefaultsKey) {
        self.set(object, forKey: key.rawValue)
    }
}
