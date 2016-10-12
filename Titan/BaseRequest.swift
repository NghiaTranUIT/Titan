//
//  BaseRequest.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol Request {
    
    var baseURL: NSURL! {get}
    
    var param: [String: AnyObject]? {get}
    
    var block: ResponseBlock? {get}
    
    func toOperation() -> [BaseOperation]
    
    func executeOnBackground()
}

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
