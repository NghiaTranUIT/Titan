//
//  PostgreSQLManager.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/18/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import SwiftyPostgreSQL
import RxSwift

public enum ConnectState {
    case connected
    case connecting
    case none
}

//
// MARK: - PostgreSQLManager
open class PostgreSQLManager {
    
    //
    // MARK: - Singleton
    static let shared = PostgreSQLManager()
    
    //
    // MARK: - Variable
    fileprivate lazy var database: Database = {return Database()}()
    fileprivate var currentDbConnection: Connection {
        return self.database.connections.first!
    }
    
    // Connection State
    fileprivate var _connectState = ConnectState.none
    public var connectState: ConnectState { return self._connectState}
    fileprivate var connectionParam: ConnectionParam!
    
    //
    // MARK: - Public
    
    // Open connection
    func openConnection(with databaseObj: DatabaseObj) -> Driver<Void> {
        
        // Lock
        objc_sync_exit(self._connectState)
        defer {objc_sync_exit(self._connectState)}
        
        // Guard
        if self._connectState == .connecting {
            let error = NSError.errorWithMessage(message: "Database is connecting")
            return Driver.error(error)
        }
        
        guard self._connectState == .none else {
            let error = NSError.errorWithMessage(message: "Database is connected")
            return Driver.error(error)
        }
        
        // Connect
        self._connectState = .connecting
        
        // Observer
        Observable<Void>.create {[weak self] (observer) -> Disposable in
            
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
    func closeConnection() -> Observable<Void> {
        
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
}
