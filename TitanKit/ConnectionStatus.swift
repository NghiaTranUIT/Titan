//
//  ConnectionStatus.swift
//  TitanKit
//
//  Created by Nghia Tran on 11/16/16.
//  Copyright © 2016 Titan. All rights reserved.
//

import Foundation
import libpq

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
    
    
    //
    // MARK: - Public
    public init(_ connectionPtr: OpaquePointer?) {
        
        // Get status
        let status = PQstatus(connectionPtr)
        
        // Parser
        if status == libpq.CONNECTION_OK {
            self =  .CONNECTION_OK
        }
        if status == libpq.CONNECTION_BAD {
            self = .CONNECTION_BAD
        }
        if status == libpq.CONNECTION_STARTED {
            self = .CONNECTION_STARTED
        }
        if status == libpq.CONNECTION_MADE {
            self = .CONNECTION_MADE
        }
        if status == libpq.CONNECTION_AWAITING_RESPONSE {
            self = .CONNECTION_AWAITING_RESPONSE
        }
        if status == libpq.CONNECTION_AUTH_OK {
            self = .CONNECTION_AUTH_OK
        }
        if status == libpq.CONNECTION_SETENV {
            self = .CONNECTION_SETENV
        }
        if status == libpq.CONNECTION_SSL_STARTUP {
            self = .CONNECTION_SSL_STARTUP
        }
        if status == libpq.CONNECTION_SSL_STARTUP {
            self = .CONNECTION_NEEDED
        }
        self = .UNKNOW
    }
    
    public static func getErrorMessage(with connectionPtr: OpaquePointer?) -> String {
        return String(cString: PQerrorMessage(connectionPtr))
    }
}
