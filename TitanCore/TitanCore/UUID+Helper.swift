//
//  UUID+Helper.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/4/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation

//
// MARK: - UUID + Short
// Generate UUID String with short version
// 8 Charactter
extension UUID {
    
    /// Short UUID
    static func shortUUID() -> String {
        let uuid = UUID().uuidString
        let index = uuid.index(uuid.startIndex, offsetBy: 8)
        return uuid.substring(to: index)
    }
}
