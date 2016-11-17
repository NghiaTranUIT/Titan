//
//  File.swift
//  TitanKit
//
//  Created by Nghia Tran on 11/16/16.
//  Copyright © 2016 Titan. All rights reserved.
//

import Foundation
import libpq

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
    case unsupport = 999
}


//
// MARK: - Query Result Row
open class QueryResultRow {
    
    //
    // MARK: - Variable
    /// ColName <-> Value
    public var results: [String: Any?] = [:]
    
    
    //
    // MARK: - Init
    public init(_ results: [String: Any?]) {
        self.results = results
    }
    
    
    public class func resultRow(atRowIndex rowIndex: Int32, colIndex: [String], colTypes: [ColumnType], resultPtr: OpaquePointer) -> QueryResultRow {
        var results: [String: Any?] = [:]
        
        for col in 0..<Int32(colIndex.count) {
            
            // Name col
            let nameCol = colIndex[Int(col)]
            
            // Check null
            if PQgetisnull(resultPtr, rowIndex, col) == 1 {
                // Set Null
                // Note that PQgetvalue will return an empty string, not a null pointer, for a null field.
                // Ref: https://www.postgresql.org/docs/9.1/static/libpq-exec.html
                results[nameCol] = nil
                continue
            }
            
            // Get raw value
            let rawData = String(cString: PQgetvalue(resultPtr, rowIndex, col))
            
            // Convert data type
            guard colTypes[Int(col)] != .unsupport else {
                // Return String if the type is unsupport
                results[nameCol] = rawData
                continue
            }
            
            // Convert normal data
            var value: Any!
            switch colTypes[Int(col)] {
            case .boolean:
                value = rawData == "t" ? true : false
            case .int16:
                value = Int16(rawData)
            case .int32:
                value = Int32(rawData)
            case .int64:
                value = Int64(rawData)
            case .text:
                value = rawData
            case .singleFloat:
                value = Float(rawData)
            case .doubleFloat:
                value = Double(rawData)
            default:
                break
            }
            
            // Set data
            results[nameCol] = value
        }
        
        return QueryResultRow(results)
    }
}
