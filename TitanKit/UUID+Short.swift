//
//  UUID+Short.swift
//  TitanKit
//
//  Created by Nghia Tran on 2/5/17.
//  Copyright © 2017 Titan. All rights reserved.
//

import Foundation

extension UUID {
    
    /// Short UUID
    static func shortUUID() -> String {
        let uuid = UUID().uuidString
        let index = uuid.index(uuid.startIndex, offsetBy: 8)
        return uuid.substring(to: index)
    }
}
