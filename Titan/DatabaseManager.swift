//
//  DatabaseManager.swift
//  Titan
//
//  Created by Nghia Tran on 1/29/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation
import TitanKit
import PromiseKit

enum ConnectState {
    case connected
    case connecting
    case none
}

class DatabaseManager {

    //
    // MARK: - Singleton
    static let shared = DatabaseManager()
    
    //
    // MARK: - Variable
    fileprivate lazy var database: Database = {return Database()}()
    fileprivate var currentDbConnection: Connection {
        return self.database.connections.first!
    }
    
    // Connection State
    fileprivate var _connectState = ConnectState.none
    var connectState: ConnectState {
        return self._connectState
    }
    fileprivate var connectionParam: ConnectionParam!

    //
    // MARK: - Public
    
    // Open connection
    func openConnection(with databaseObj: DatabaseObj) -> Promise<Void> {
        
        // Lock
        objc_sync_exit(self._connectState)
        defer {objc_sync_exit(self._connectState)}
        
        // Guard
        if self._connectState == .connecting {
            let error = NSError.errorWithMessage(message: "Database is connecting")
            return Promise(error: error)
        }
        
        guard self._connectState == .none else {
            let error = NSError.errorWithMessage(message: "Database is connected")
            return Promise(error: error)
        }
        
        // Connect
        self._connectState = .connecting
        
        return Promise { (fullfill, reject) in
            
            // Connect
            let param = databaseObj.buildConnectionParam()
            let op = ConnectionDatabaseOperation(param: param, database: self.database)
            op.executeOnBackground(with: { (result, _) in
                
                guard let result = result as? ConnectionResult else {
                    let error = NSError.errorWithMessage(message: "Fatal error")
                    self._connectState = .none
                    reject(error)
                    return
                }
                
                guard result.status == ConnectionStatus.CONNECTION_OK else {
                    let error = NSError.errorWithMessage(message: result.msgError)
                    self._connectState = .none
                    reject(error)
                    return
                }
                
                // Get connection
                guard let _ = result.connection else {
                    let error = NSError.errorWithMessage(message: result.msgError)
                    self._connectState = .none
                    reject(error)
                    return
                }
                
                // Success
                self._connectState = .connected
                fullfill()
            })
        }
    }
    
    // Close all
    func closeConnection() -> Promise<Void> {
        
        // Lock
        objc_sync_exit(self._connectState)
        defer {objc_sync_exit(self._connectState)}
        
        guard self._connectState == .connected else {
            let error = NSError.errorWithMessage(message: "No database connected")
            return Promise(error: error)
        }
        
        return Promise(resolvers: { (fullfill, reject) in
            self.database.closeAllConnection()
            self._connectState = .none
            fullfill()
        })
        
    }
    
    // Fetch all table schema information
    func fetchTableInformation() -> Promise<[Table]> {
        
        guard self._connectState == .connected else {
            let error = NSError.errorWithMessage(message: "No database connected")
            return Promise(error: error)
        }
        
        return Promise { (fullfill, reject) in
            
            let op = FetchTableSchemaInfoOperation(connect: self.currentDbConnection)
            op.executeOnBackground(with: { (result, _ ) in
                guard let tables = result as? [Table] else {
                    let error = NSError.errorWithMessage(message: "Fatal error")
                    self._connectState = .none
                    reject(error)
                    return
                }
                
                fullfill(tables)
            })
        }
    }
    
    // Fetch query
    func fetchQuery(_ query: PostgreQuery) -> Promise<QueryResult> {
        
        guard self._connectState == .connected else {
            let error = NSError.errorWithMessage(message: "No database connected")
            return Promise(error: error)
        }
        
        return Promise { (fullfill, reject) in
            
            let op = QueryPostgreSQLOperation(connect: self.currentDbConnection, rawQuery: query.rawQuery)
            op.executeOnBackground(with: { (result, _ ) in
                guard let queryResult = result as? QueryResult else {
                    let error = NSError.errorWithMessage(message: "Fatal error")
                    self._connectState = .none
                    reject(error)
                    return
                }
                
                fullfill(queryResult)
            })
        }
    }
}
