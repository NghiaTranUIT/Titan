//
//  BaseRequest.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift


//
// MARK: - Request protocol
// We conform with Action protocol from ReSwift
// To make sure we can reuse Request as Action
// Don't need to create seperate action object
protocol Request: Action {
    
    var baseURL: NSURL {get}
    
    var endpoint: String {get}
    
    var param: [String: AnyObject]? {get}
    
    var block: ResponseBlock? {get}
    
    func toOperation() -> [BaseOperation]
    
    func executeOnBackground()
}

//
// MARK: - Default implementation
extension Request {
    
    var baseURL: NSURL {
        get {
            return NSURL(string: Constants.Endpoint.BaseURL)!
        }
    }
    
    var param: [String: AnyObject]? {
        get {
            return nil
        }
    }
    
    var block: ResponseBlock? {
        get {
            return nil
        }
    }
    
    func executeOnBackground() {
        
        // Get operations
        let operations = self.toOperation()
        
        // Enqueue
        QueueManager.shared.enqueueOnBackground(operations: operations, block: self.block)
    }
}
