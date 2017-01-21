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
        
        return newValue
    }
}


//
// MARK: - Query Result Row
open class QueryResultRow {
    
    //
    // MARK: - Variable
    /// ColName <-> Value
    public var results: [String: Field] = [:]
    
    
    public subscript(colName: String) -> Field? {
        return self.results[colName]
    }
    
    //
    // MARK: - Init
    public init(_ results: [String: Field]) {
        self.results = results
    }
    
    
    public class func buildResultRow(atRowIndex rowIndex: Int32, colIndex: [String], colTypes: [ColumnType], resultPtr: OpaquePointer) -> QueryResultRow {
        
        var results: [String: Field] = [:]
        
        for i in 0..<colIndex.count {
            
            let nameCol = colIndex[i]
            let colType = colTypes[i]
            let field = Field(resultPtr: resultPtr, colType: colType, rowIndex: Int(rowIndex), colIndex: i)
            
            // Save
            results[nameCol] = field
        }
        
        return QueryResultRow(results)
    }
}


extension QueryResultRow: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "\(self.results)"
    }
}
