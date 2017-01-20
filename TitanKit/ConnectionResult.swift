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
    init(connectionPtr: OpaquePointer?, connectionParam: ConnectionParam) {
        let status = ConnectionStatus(connectionPtr)
        let msg = ConnectionStatus.getErrorMessage(with: connectionPtr)
        self.status = status
        self.msgError = msg
        
        // Init Connection
        if self.status == .CONNECTION_OK {
            self.connection = Connection(connectionPtr: connectionPtr!, connectionParam: connectionParam)
        }
    }
    
    public static var unknowStatus: ConnectionResult {get{return ConnectionResult()}}
}

