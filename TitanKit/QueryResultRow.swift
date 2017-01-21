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
// MARK: - Query Result Row
open class QueryResultRow {
    
    //
    // MARK: - Variable
    /// ColName <-> Value
    fileprivate var results: [String: Field] = [:]
    
    
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
