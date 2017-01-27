//
//  Error.swift
//  Titan
//
//  Created by Nghia Tran on 10/24/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation

extension NSError {

    /// Unknow error
    static func unknowError() -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: "Unknow error"]
        return NSError(domain: "com.fe.titan.defaultError", code: 999, userInfo: userInfo)
    }
    
    /// JSON Mapper Error
    static func jsonMapperError() -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: "JSON Mapper error"]
        return NSError(domain: "com.fe.titan.defaultError", code: 998, userInfo: userInfo)
    }
}
