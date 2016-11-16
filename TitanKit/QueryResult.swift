//
//  Result.swift
//  TitanKit
//
//  Created by Nghia Tran on 11/15/16.
//  Copyright © 2016 Titan. All rights reserved.
//

import Foundation

public struct QueryResult {
    
    //
    // MARK: - Variable
    
    
    /// Result Pointer
    public var resultPtr: OpaquePointer?
    
    
    /// Status
    
    
    //
    // MARK: - Init
    public init(_ resultPtr: OpaquePointer?) {
        self.resultPtr = resultPtr
    }
}
