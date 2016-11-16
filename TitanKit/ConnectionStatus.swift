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
    public static func getStatus(with connectionPtr: OpaquePointer?) -> ConnectionStatus {
        
        // Get status
        let status = PQstatus(connectionPtr)
        
        // Parser
        if status == libpq.CONNECTION_OK {
            return .CONNECTION_OK
        }
        if status == libpq.CONNECTION_BAD {
            return .CONNECTION_BAD
        }
        if status == libpq.CONNECTION_STARTED {
            return .CONNECTION_STARTED
        }
        if status == libpq.CONNECTION_MADE {
            return .CONNECTION_MADE
        }
        if status == libpq.CONNECTION_AWAITING_RESPONSE {
            return .CONNECTION_AWAITING_RESPONSE
        }
        if status == libpq.CONNECTION_AUTH_OK {
            return .CONNECTION_AUTH_OK
        }
        if status == libpq.CONNECTION_SETENV {
            return .CONNECTION_SETENV
        }
        if status == libpq.CONNECTION_SSL_STARTUP {
            return .CONNECTION_SSL_STARTUP
        }
        if status == libpq.CONNECTION_SSL_STARTUP {
            return .CONNECTION_NEEDED
        }
        return .UNKNOW
    }
    
    public static func getErrorMessage(with connectionPtr: OpaquePointer?) -> String {
        return String(cString: PQerrorMessage(connectionPtr))
    }
}
