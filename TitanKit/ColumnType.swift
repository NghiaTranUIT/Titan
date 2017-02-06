//
//  ColumnType.swift
//  TitanKit
//
//  Created by Nghia Tran on 1/21/17.
//  Copyright © 2017 Titan. All rights reserved.
//

import Foundation

//
// MARK: - Col type for Postgres
// The OIDs of the built-in data types are defined
// in the file src/include/catalog/pg_type.h in the source tree.
public enum ColumnType: UInt32 {
    
    case boolean = 16
    case int64 = 20
    case int16 = 21
    case int32 = 23
    case text = 25
    case singleFloat = 700
    case doubleFloat = 701
    case varchar = 1043
    case byte = 17
    case char = 18
    case json = 114
    case date = 1082
    case time = 1083
    case timestamp = 1114
    case unsupport = 0
    
    /// Build
    public static func build(rawValue: UInt32) -> ColumnType {
        let newValue = ColumnType(rawValue: rawValue) ?? .unsupport
        
        // Log
        if newValue == .unsupport {
            Logger.error("Didn't support colType = \(rawValue)")
        }
        
        print("oid = \(rawValue) = \(newValue)")
        return newValue
    }
}

//
// MARK: - Equatable
extension ColumnType: Equatable {
    public static func ==(lhs: ColumnType, rhs: ColumnType) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
