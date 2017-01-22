//
//  Parameter.swift
//  TitanKit
//
//  Created by Nghia Tran on 11/16/16.
//  Copyright © 2016 Titan. All rights reserved.
//

import Foundation
import libpq

public struct Parameter {
    
    //
    // MARK: - Variable
    /// Param Value
    public let paramValue: UnsafePointer<UnsafePointer<Int8>?>!
    
    /// Param Count
    public var paramCount: Int32 = 0
    
    /// Param Type
    public var paramType: UnsafePointer<Oid>? = nil
    
    /// Param Length
    public var paramLength: UnsafePointer<Int32>? = nil
    
    // Param format
    public var paramFormat: UnsafePointer<Int32>? = nil
    
    //
    // MARK: - Init
    public init(_ param: [CustomStringConvertible]) {
        self.paramCount = Int32(param.count)
        var values = UnsafeMutablePointer<UnsafePointer<Int8>?>.allocate(capacity: param.count)
        
        // Release
        defer {
            values.deinitialize()
            values.deallocate(capacity: param.count)
        }
        
        // Convert
        var temps = [Array<UInt8>]()
        for (i, value) in param.enumerated() {
            temps.append(Array<UInt8>(value.description.utf8) + [0])
            let unsafePointer = UnsafeRawPointer(temps.last!).assumingMemoryBound(to: Int8.self)
            values[i] = unsafePointer
        }
        
        self.paramValue = UnsafePointer(values)
    }
}
