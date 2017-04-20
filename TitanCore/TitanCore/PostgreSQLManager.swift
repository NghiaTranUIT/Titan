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
    func openConnection(with databaseObj: DatabaseObj) -> Observable<Void> {
        
        // Lock
        objc_sync_exit(self._connectState)
        defer {objc_sync_exit(self._connectState)}
        
        // Guard
        if self._connectState == .connecting {
            let error = NSError.errorWithMessage(message: "Database is connecting")
            return Observable.error(error)
        }
        
        guard self._connectState == .none else {
            let error = NSError.errorWithMessage(message: "Database is connected")
            return Observable.error(error)
        }
        
        // Connect
        self._connectState = .connecting
        
        // Observer
        return Observable<Void>.create {[unowned self] (observer) -> Disposable in
            
            // Connect postgreSQL on background
            let param = databaseObj.buildConnectionParam()
            let op = ConnectPostgreOperation(param: param, database: self.database)
            op.executeOnBackground(block: { (resultOperation) in
                
                switch resultOperation {
                case .failed(let error):
                    
                    // Error
                    observer.onError(error)
                    
                case .success(let result):
                    
                    // Check result pointer
                    guard result.status == ConnectionStatus.CONNECTION_OK else {
                        let error = NSError.errorWithMessage(message: result.msgError)
                        self._connectState = .none
                        observer.onError(error)
                        return
                    }
    
                    // Check connection pointer
                    guard let _ = result.connection else {
                        let error = NSError.errorWithMessage(message: result.msgError)
                        self._connectState = .none
                        observer.onError(error)
                        return
                    }
                    
                    // All success
                    observer.onNext()
                    observer.onCompleted()
                }
            })
            
            // Dispose
            return Disposables.create()
        }
    }
    
    /// Close crrent connection
    func closeConnection() -> Observable<Void> {
        
        // Lock
        objc_sync_exit(self._connectState)
        defer {objc_sync_exit(self._connectState)}
        
        guard self._connectState == .connected else {
            let error = NSError.errorWithMessage(message: "No database connected")
            return Observable.error(error)
        }
        
        // Observer
        return Observable<Void>.create {[unowned self] (observer) -> Disposable in
            
            // Close
            self.database.closeAllConnection()
            self._connectState = .none
            
            // Success
            observer.onNext()
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    /// Fetch table schema
    func fetchTableSchema() -> Observable<[Table]> {
        
        guard self._connectState == .connected else {
            let error = NSError.errorWithMessage(message: "No database connected")
            return Observable.error(error)
        }
        
        return Observable<[Table]>.create({ observer -> Disposable in
            
            let op = FetchTableSchemaOperation(connect: self.currentDbConnection)
            op.executeOnBackground(block: { resultOperation in
                
                switch resultOperation {
                case .failed(let error):
                    
                    // Error
                    observer.onError(error)
                    
                case .success(let result):
                    
                    // All success
                    observer.onNext(result)
                    observer.onCompleted()
                }
            })
            
            return Disposables.create()
        })
    }
}
