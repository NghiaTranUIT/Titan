//
//  Query.swift
//  TitanKit
//
//  Created by Nghia Tran on 11/15/16.
//  Copyright © 2016 Titan. All rights reserved.
//

import Foundation
import libpq


/// Type result
public enum QueryResultFormat: Int32 {
    case text = 0
    case binary = 1
}

/// Represent for Query string
public struct Query {
    
    //
    // MARK: - Variable
    public let string: String
    fileprivate let param: Parameter!
    
    
    /// Param Count
    public var paramCount: Int32 {
        get { return self.param.paramCount}
    }
    
    
    /// Param type
    public var paramType: UnsafePointer<Oid>? {
        get {return self.param.paramType}
    }
    
    
    /// Param Value
    public var paramValue: UnsafePointer<UnsafePointer<Int8>?> {
        get {
            return self.param.paramValue
        }
    }
    
    
    // Param Length
    public var paramLength: UnsafePointer<Int32>? {
        get { return self.param.paramLength }
    }
    
    
    // Param format
    public var paramFormat: UnsafePointer<Int32>? {
        get { return self.param.paramFormat }
    }
    
    
    /// Result format
    public var resultFormat: QueryResultFormat {
        get {return .text}
    }
}

//
// MARK: - ExpressibleByStringLiteral
// By conformed ExpressibleByStringLiteral, we can allow init Query from string easily
extension Query: ExpressibleByStringLiteral {
    
    /// typealias
    public typealias StringLiteralType = String
    public typealias ExtendedGraphemeClusterLiteralType = String
    public typealias UnicodeScalarLiteralType = String
    
    
    /// Implement require methods
    public init(_ string: String, param: [CustomStringConvertible] = []) {
        self.string = string
        self.param = Parameter(param)
    }
    
    public init(stringLiteral value: String) {
        self.init(value)
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(value)
    }
    
    public init(unicodeScalarLiteral value: String) {
        self.init(value)
    }
    
}

//
// MARK: - Debugable
extension Query: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        get {
            return self.string
        }
    }
}
