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
    private let connectionPtr: OpaquePointer!
    
    
    //
    // MARK: - Init
    init(connectionPtr: OpaquePointer) {
        self.connectionPtr = connectionPtr
    }
    
    
    //
    // MARK: - Public
    
    /// Close connection
    open func closeConnection() {
        PQfinish(self.connectionPtr)
    }
    
    
    /// Execute query
    open func execute(query: Query) -> QueryResult {
        return QueryResult()
    }
}
