//
//  ResultStatus.swift
//  TitanKit
//
//  Created by Nghia Tran on 11/16/16.
//  Copyright © 2016 Titan. All rights reserved.
//

import Foundation
import libpq

public enum ResultStatus {
    
    // Case
    case PGRES_EMPTY_QUERY
    case PGRES_COMMAND_OK
    case PGRES_TUPLES_OK
    case PGRES_COPY_OUT
    case PGRES_COPY_IN
    case PGRES_BAD_RESPONSE
    case PGRES_NONFATAL_ERROR
    case PGRES_FATAL_ERROR
    case PGRES_COPY_BOTH
    case PGRES_SINGLE_TUPLE
    case UNKNOW
    
    
    //
    // MARK: - Init
    public init(_ resultPtr: OpaquePointer?) {
        
        let status = PQresultStatus(resultPtr)
        
        if status == libpq.PGRES_EMPTY_QUERY {
            self = .PGRES_EMPTY_QUERY
            return
        }
        if status == libpq.PGRES_COMMAND_OK {
            self = .PGRES_COMMAND_OK
            return
        }
        if status == libpq.PGRES_TUPLES_OK {
            self = .PGRES_TUPLES_OK
            return
        }
        if status == libpq.PGRES_COPY_OUT {
            self = .PGRES_COPY_OUT
            return
        }
        if status == libpq.PGRES_COPY_IN {
            self = .PGRES_COPY_IN
            return
        }
        if status == libpq.PGRES_BAD_RESPONSE {
            self = .PGRES_BAD_RESPONSE
            return
        }
        if status == libpq.PGRES_NONFATAL_ERROR {
            self = .PGRES_NONFATAL_ERROR
            return
        }
        if status == libpq.PGRES_FATAL_ERROR {
            self = .PGRES_FATAL_ERROR
            return
        }
        if status == libpq.PGRES_EMPTY_QUERY {
            self = .PGRES_EMPTY_QUERY
            return
        }
        if status == libpq.PGRES_COPY_BOTH {
            self = .PGRES_COPY_BOTH
            return
        }
        if status == libpq.PGRES_SINGLE_TUPLE {
            self = .PGRES_SINGLE_TUPLE
            return
        }
        
        self = .UNKNOW
    }
    
    func toString() -> String {
        switch self {
        case .PGRES_BAD_RESPONSE:
            return "The server's response was not understood"
        case .PGRES_COMMAND_OK:
            return "Successful completion of a command returning no data."
        case .PGRES_COPY_BOTH:
            return "Copy In/Out (to and from server) data transfer started. This is currently used only for streaming replication."
        case .PGRES_COPY_IN:
            return "Copy In (to server) data transfer started."
        case .PGRES_COPY_OUT:
            return "Copy Out (from server) data transfer started."
        case .PGRES_EMPTY_QUERY:
            return "The string sent to the server was empty."
        case .PGRES_FATAL_ERROR:
            return "A fatal error occurred."
        case .PGRES_NONFATAL_ERROR:
            return "A nonfatal error (a notice or warning) occurred."
        case .PGRES_SINGLE_TUPLE:
            return "Successful completion of a command returning data"
        case .PGRES_TUPLES_OK:
            return "Successful completion of a command returning data"
        case .UNKNOW:
            return "Unknow error"
        }
    }
}
