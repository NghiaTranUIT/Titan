//
//  Database.swift
//  TitanKit
//
//  Created by Nghia Tran on 11/15/16.
//  Copyright © 2016 Titan. All rights reserved.
//

import Foundation
import libpq

open class Database {
    
    //
    // MARK: - Variable
    
    /// Connections pool
    fileprivate let connections: [Connection] = []
    
    
    // Share instance
    static let share = Database()
    
    
    //
    // MARK: - Public
    
    
    /// Create Connection to database
    open func connectDatabase(withParam param: ConnectionParam) -> ConnectionResult {
        
        // Connection
        let _connectionPtr = PQsetdbLogin(param.host, param.port, param.options, "", param.databaseName, param.user, param.password)
        guard let connectionPtr = _connectionPtr else {
            return ConnectionResult.unknowStatus
        }
        
        // Get status
        let result = ConnectionResult(connectionPtr: connectionPtr)
        
        // Return
        return result
    }
}
