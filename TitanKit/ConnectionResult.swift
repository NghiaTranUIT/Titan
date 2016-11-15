//
//  ConnectionStatus.swift
//  TitanKit
//
//  Created by Nghia Tran on 11/15/16.
//  Copyright © 2016 Titan. All rights reserved.
//

import Foundation
import libpq

public struct ConnectionResult: Error {
    
    
    /// status
    public var status: ConnectionStatus = .UNKNOW
    
    
    // Message error
    public var msgError = "Unknow"
    
    
    /// Connection
    public var connection: Connection? = nil
    
    /// Default init
    init() {
        
    }
    
    
    /// Init with connection Pointer
    init(connectionPtr: OpaquePointer?) {
        
        if connectionPtr != nil {
            self.status = .UNKNOW
            self.msgError = "Unknow"
        }
        
        let status = PQstatus(connectionPtr)
        let msg = String(cString: PQerrorMessage(connectionPtr))
        self.msgError = msg
        
        if status == libpq.CONNECTION_OK {
            self.status =  .CONNECTION_OK
            let connection = Connection(connectionPtr: connectionPtr!)
            self.connection = connection
        }
        if status == libpq.CONNECTION_BAD {
            self.status = .CONNECTION_BAD
        }
        if status == libpq.CONNECTION_STARTED {
            self.status = .CONNECTION_STARTED
        }
        if status == libpq.CONNECTION_MADE {
            self.status = .CONNECTION_MADE
        }
        if status == libpq.CONNECTION_AWAITING_RESPONSE {
            self.status = .CONNECTION_AWAITING_RESPONSE
        }
        if status == libpq.CONNECTION_AUTH_OK {
            self.status = .CONNECTION_AUTH_OK
        }
        if status == libpq.CONNECTION_SETENV {
            self.status = .CONNECTION_SETENV
        }
        if status == libpq.CONNECTION_SSL_STARTUP {
            self.status = .CONNECTION_SSL_STARTUP
        }
        if status == libpq.CONNECTION_SSL_STARTUP {
            self.status = .CONNECTION_NEEDED
        }
    }
    
    static let unknowStatus = ConnectionResult()
}


public enum ConnectionStatus {
    
    /// State
    case CONNECTION_OK
    case CONNECTION_BAD
    case CONNECTION_STARTED
    case CONNECTION_MADE
    case CONNECTION_AWAITING_RESPONSE
    case CONNECTION_AUTH_OK
    case CONNECTION_SETENV
    case CONNECTION_SSL_STARTUP
    case CONNECTION_NEEDED
    case UNKNOW
}
