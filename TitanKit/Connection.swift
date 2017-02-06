//
//  Connection.swift
//  TitanKit
//
//  Created by Nghia Tran on 11/15/16.
//  Copyright © 2016 Titan. All rights reserved.
//

import Foundation
import libpq

open class Connection {
    
    //
    // MARK: - Variable
    fileprivate let connectionPtr: OpaquePointer!
    
    /// Param
    fileprivate let connectionParam: ConnectionParam!
    
    /// Public table
    public lazy var publicTables: [Table] = self.fetchAllTables()
    
    // Database name
    public lazy var databaseName: String = self.getDatabaseName()
    
    //
    // MARK: - Init
    init(connectionPtr: OpaquePointer, connectionParam: ConnectionParam) {
        self.connectionPtr = connectionPtr
        self.connectionParam = connectionParam
    }
    
    //
    // MARK: - Public
    
    /// Close connection
    open func closeConnection() {
        PQfinish(self.connectionPtr)
    }
    
    /// Execute query
    open func execute(query: Query) -> QueryResult {
        
        let queryResultPtr = PQexecParams(self.connectionPtr,
                                          query.string,
                                          query.paramCount,
                                          query.paramType,
                                          query.paramValue,
                                          query.paramLength,
                                          query.paramFormat,
                                          query.resultFormat.rawValue)
        
        return QueryResult(queryResultPtr)
    }
}

//
// MARK: - Private
extension Connection {
    
    /// Fetch all table
    fileprivate func fetchAllTables() -> [Table] {
        
        let query: Query = "SELECT * FROM information_schema.tables WHERE table_schema='public'"
        let result = self.execute(query: query)
        
        // Init
        let tables: [Table] = result.rows.map { (row) -> Table in
            return Table(resultRow: row)
        }
        
        return tables
    }
    
    fileprivate func getDatabaseName() -> String {
        let name = String(cString: PQdb(self.connectionPtr))
        return name
    }
}
