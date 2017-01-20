//
//  Result.swift
//  TitanKit
//
//  Created by Nghia Tran on 11/15/16.
//  Copyright © 2016 Titan. All rights reserved.
//

import Foundation
import libpq

open class QueryResult {
    
    //
    // MARK: - Variable
    
    
    /// Result Pointer
    /*
    Returns a PGresult pointer or possibly a NULL pointer.
     
    A non-null pointer will generally be returned except in out-of-memory conditions 
    or serious errors such as inability to send the command to the server.
     
    The PQresultStatus function should be called to check the return value for any errors 
    (including the value of a null pointer, in which case it will return PGRES_FATAL_ERROR).
    Use PQerrorMessage to get more information about such errors.
     
    // Ref: https://www.postgresql.org/docs/9.1/static/libpq-exec.html
    */
    public var resultPtr: OpaquePointer?
    
    
    /// Status
    public let resultStatus: ResultStatus!
    public let resultMessage: String!
    
    
    //
    // MARK: - Query Result
    
    
    // Number of col
    public lazy var numberOfColumns: Int = {
        guard let resultPtr = self.resultPtr else {return 0}
        return Int(PQnfields(resultPtr))
    }()
    
    
    /// Number of row
    public lazy var numberOfRows: Int = {
        guard let resultPtr = self.resultPtr else {return 0}
        return Int(PQntuples(resultPtr))
    }()
    
    
    /// Rows
    public lazy var rows: [QueryResultRow] = self.getRows()
    
    
    /// Col name at index
    public lazy var columnsName: [String] = self.getColumnsName()
    
    
    /// Type of colums
    lazy var columnTypes: [ColumnType] = self.getTypeOfColIndex()
    
    
    /// Command Status
    public lazy var commandStatus: String = {
        guard let resultPtr = self.resultPtr else {return ""}
        return String(cString:PQcmdStatus(resultPtr))
    }()
    
    
    /// Rows affected
    public lazy var rowsAffected: String = {
        guard let resultPtr = self.resultPtr else {return ""}
        return String(cString:PQcmdTuples(resultPtr))
    }()
    
    
    //
    // MARK: - Init
    public init(_ resultPtr: OpaquePointer?) {
        self.resultPtr = resultPtr
        self.resultStatus = ResultStatus(resultPtr)
        self.resultMessage = self.resultStatus.toString()
    }
    
    deinit {
        PQclear(self.resultPtr)
    }
}


//
// MARK: - Private
extension QueryResult {
    
    
    /// Lazy get Row
    fileprivate func getRows() -> [QueryResultRow] {
        
        guard let resultPtr = self.resultPtr else {
            return []
        }
        
        // Rows
        var rows: [QueryResultRow] = []
        rows.reserveCapacity(self.numberOfRows)
        
        // Get value
        for rowIndex in 0..<self.numberOfRows {
            let row = QueryResultRow.resultRow(atRowIndex: Int32(rowIndex),
                                               colIndex: self.columnsName,
                                               colTypes: self.columnTypes,
                                               resultPtr: resultPtr)
            rows.append(row)
        }
        
        // Return
        return rows
    }
    
    
    /// Lazy get type of cols
    fileprivate func getTypeOfColIndex() -> [ColumnType] {
        guard let resultPtr = self.resultPtr else {return []}
        
        var types: [ColumnType] = []
        types.reserveCapacity(self.numberOfColumns)
        
        for i in 0..<Int32(self.numberOfColumns) {
            let typeId = PQftype(resultPtr, i)
            
            guard let type = ColumnType(rawValue: typeId) else {
                types.append(ColumnType.unsupport)
                continue
            }
            types.append(type)
        }
        
        return types
    }
    
    
    /// Lazy get col name
    fileprivate func getColumnsName() -> [String] {
        guard let resultPtr = self.resultPtr else {return []}
        
        var cols: [String] = []
        let count = Int32(self.numberOfColumns)
        
        for i in 0..<count {
            let name = String(cString: PQfname(resultPtr, i))
            cols.append(name)
        }
        
        return cols
    }
}
