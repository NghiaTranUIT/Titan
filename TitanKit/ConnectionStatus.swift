//
//  ConnectionStatus.swift
//  TitanKit
//
//  Created by Nghia Tran on 11/15/16.
//  Copyright © 2016 Titan. All rights reserved.
//

import Foundation
import libpq

public struct DataConnectionStatus: Error {
    
    
    /// State
    var state: ConnectionStatus = .UNKNOW
    
    
    // Message error
    var msgError = "Unknow"
    
    
    /// Default init
    init() {
        
    }
    
    
    /// Init with connection Pointer
    init(connectionPtr: OpaquePointer?) {
        
        if connectionPtr != nil {
            self.state = .UNKNOW
            self.msgError = "Unknow"
        }
        
        let status = PQstatus(connectionPtr)
        let msg = String(cString: PQerrorMessage(connectionPtr))
        self.msgError = msg
        
        if status == libpq.CONNECTION_OK {
            self.state =  .CONNECTION_OK
        }
        if status == libpq.CONNECTION_BAD {
            self.state = .CONNECTION_BAD
        }
        if status == libpq.CONNECTION_STARTED {
            self.state = .CONNECTION_STARTED
        }
        if status == libpq.CONNECTION_MADE {
            self.state = .CONNECTION_MADE
        }
        if status == libpq.CONNECTION_AWAITING_RESPONSE {
            self.state = .CONNECTION_AWAITING_RESPONSE
        }
        if status == libpq.CONNECTION_AUTH_OK {
            self.state = .CONNECTION_AUTH_OK
        }
        if status == libpq.CONNECTION_SETENV {
            self.state = .CONNECTION_SETENV
        }
        if status == libpq.CONNECTION_SSL_STARTUP {
            self.state = .CONNECTION_SSL_STARTUP
        }
        if status == libpq.CONNECTION_SSL_STARTUP {
            self.state = .CONNECTION_NEEDED
        }
    }
    
    static let unknowStatus = DataConnectionStatus()
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
