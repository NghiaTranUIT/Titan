//
//  BaseOperation.swift
//  Titan
//
//  Created by Nghia Tran on 1/29/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation

class BaseOperation: Operation {
    
    //
    // MARK: - Variable
    var response: Any?
    var error: NSError?
    var uuid = UUID.shortUUID()

    //
    // MARK: - Override
    
    deinit {
        self.error = nil
        self.response = nil
    }
    
    /// Execute
    internal var _executing: Bool = false
    override var isExecuting: Bool {
        get {
            return _executing
        }
        set {
            if _executing != newValue {
                willChangeValue(forKey: "isExecuting")
                _executing = newValue
                didChangeValue(forKey: "isExecuting")
            }
        }
    }
    
    /// Finish
    internal var _finished: Bool = false;
    override var isFinished: Bool {
        get {
            return _finished
        }
        set {
            if _finished != newValue {
                willChangeValue(forKey: "isFinished")
                _finished = newValue
                didChangeValue(forKey: "isFinished")
            }
        }
    }
    
    /// Async
    override var isAsynchronous: Bool {
        return true
    }
    
    /// Finish
    func finishOperation() {
        self.isExecuting = false
        self.isFinished = true
    }
    
    /// Main
    override func main() {
        
        // Executing
        self.isExecuting = true;
        
        // Load data here -> Need override
        
    }

    //
    // MARK: - Public
    func _responseError(_ error: NSError?) {
        self.finishOperation()
    }
    
    func _responeSuccess(_ respone: Any?) {
        self.response = respone
        self.error = nil
        self.finishOperation()
    }
    
    /// Check cancel
    func checkCancelOperation() -> Bool {
        
        if self.isCancelled {
            self.finishOperation()
            return true
        }
        
        return false
    }
}
