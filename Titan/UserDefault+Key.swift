//
//  UserDefault+Key.swift
//  Titan
//
//  Created by Nghia Tran on 1/29/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation

//
// MARK: - UserDefaults
enum UserDefaultsKey: String {
    case isFirstTime
    case mainWindowFrame
    case dividerPosition
    
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
