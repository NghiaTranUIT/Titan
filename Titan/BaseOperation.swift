//
//  BaseOperation.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation

typealias ResponseBlock = (Result<[String: AnyObject]>?) -> ()

class BaseOperation: Operation {
    
    //
    // MARK: - Variable
    var result: Result<[String: AnyObject]>?
    var param: [String: AnyObject]?
    
    
    //
    // MARK: - Init
    convenience init(param: [String: AnyObject]?) {
        self.init()
        self.param = param
    }
    
    // MARK:
    // MARK: Override
    // Executing
    var _executing: Bool = false
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
    
    // Finish
    var _finished: Bool = false;
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
    
    // Async
    override var isAsynchronous: Bool {
        return false
    }
    
    // Main
    func checkCancelOperation() -> Bool {
        if self.isCancelled {
            self.finishOperation()
            return true
        }
    
        return false
    }
    
    override func main() {
        
        // Executing
        self.isExecuting = true;
        
        // Load data here -> Need override
        // ...
    }
    
    // Finish
    func finishOperation() {
        self.isExecuting = false
        self.isFinished = true
    }
    
    deinit {
        Logger.info(info: "\(String(describing: self)) deinit")
    }
    

    //
    // MARK: - Public
    func executeAPI() {
        
    }
}

