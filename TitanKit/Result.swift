//
//  Result.swift
//  TitanKit
//
//  Created by Nghia Tran on 11/15/16.
//  Copyright © 2016 Titan. All rights reserved.
//

import Foundation

public enum ConnectionResult: Error {
    
    
    /// State
    case Success(connection: Connection)
    case Error(error: Error)
}
