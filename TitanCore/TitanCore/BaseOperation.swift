//
//  BaseOperation.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/18/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation

//
// MARK: - BaseOperation
class BaseOperation<Element>: Operation {
    
    //
    // MARK: - Variable
    public var response: Element?
    public var error: NSError?
    public var uuid = UUID.shortUUID()
    
    //
    // MARK: - Override
    deinit {
        self.error = nil
        self.response = nil
    }
    
    /// Execute
    internal var _executing: Bool = false
    override open var isExecuting: Bool {
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
    override open var isFinished: Bool {
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
    
    /// Failed
    func handleError(_ error: NSError?) {
        self.finishOperation()
    }
    
    /// Call when success
    func handleSuccess(_ respone: Element?) {
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
