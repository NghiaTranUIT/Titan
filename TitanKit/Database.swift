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
    fileprivate var connections: [Connection] = []
    
    
    // Share instance
    static let share = Database()
    
    
    //
    // MARK: - Init
    deinit {
        // Close all connection
        
    }
    
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
        
        // Store
        if let connection = result.connection {
            self.connections.append(connection)
        }
        
        // Return
        return result
    }
}


//
// MARK: - Private
extension Database {
    
    fileprivate func closeAllConnection() {
        for connection in self.connections {
            connection.closeConnection()
        }
        self.connections.removeAll()
    }
}
