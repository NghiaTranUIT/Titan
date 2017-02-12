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
open class Row {
    
    //
    // MARK: - Variable
    /// ColName <-> Value
    private(set) var results: [Column: Field] = [:]
    public subscript(col: Column) -> Field? {
        return self.results[col]
    }
    
    //
    // MARK: - Init
    public init(_ results: [Column: Field]) {
        self.results = results
    }
    
    public class func buildResultRow(atRowIndex rowIndex: Int32, columns: [Column], resultPtr: OpaquePointer) -> Row {
        
        var results: [Column: Field] = [:]
        
        for i in 0..<columns.count {
            let col = columns[i]
            let field = Field(resultPtr: resultPtr, rowIndex: Int(rowIndex), column: col)
            
            // Save
            results[col] = field
        }
        
        return Row(results)
    }
    
    //
    // MARK: - Public
    public func field(with col: Column) -> Field? {
        return self.results[col]
    }
    
    public func field(with colName: String) -> Field? {
        let hashableColumn = Column.fakeColumn(with: colName)
        return self.results[hashableColumn]
    }
}

extension Row: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "\(self.results)"
    }
}
