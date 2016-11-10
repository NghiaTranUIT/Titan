//
//  Result.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

enum Result<T>: Error {
    
    case Success(T)
    case Failure(Error)
    
}

extension Result {
    
    // Check if result isSuccess
    var isSuccess: Bool {
        switch self {
            case .Success:
                return true
            case .Failure:
                return false
        }
    }
    
    // Check if result is failure
    var isFailure: Bool {
        return !isSuccess
    }
    
    // Get Error
    var error: NSError? {
        switch self {
        case .Success:
            return nil
        case .Failure(let error):
            return error as NSError
        }
    }
    
    
    /// Default error
    static var defaultErrorResult: Result<NSError> {
        get {
            return Result<NSError>.Failure(NSError.defaultError())
        }
    }
}
