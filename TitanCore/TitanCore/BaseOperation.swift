//
//  BaseOperation.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/18/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation

//
// MARK: - Operation Result
/// Warrper for failed or successfully
public enum OperationResult<T> {
    
    // Case
    case failed(NSError)
    case success(T)
    
    //
    // MARK: - Init
    public static func buildResult<T>(_ operation: BaseOperation<T>) -> OperationResult<T> {
        
        // Success
        if let response = operation.response {
            return OperationResult<T>.success(response)
        }
        
        // Error
        if let error = operation.error {
            return OperationResult<T>.failed(error)
        }
        
        // Unknow
        return OperationResult<T>.failed(NSError.unknowError)
    }
}

//
// MARK: - BaseOperation
open class BaseOperation<Element>: Operation {
    
    public typealias BaseOperationCompletionBlock = (OperationResult<Element>) -> ()
    
    //
    // MARK: - Variable
    public var response: Element?
    public var error: NSError?
    public var uuid = UUID.shortUUID()
    fileprivate var baseCompletionBlock: BaseOperationCompletionBlock? {
        didSet {
            guard let block = self.baseCompletionBlock else {
                self.completionBlock = nil
                return
            }
            
            // Execute on main thread
            self.completionBlock = { [unowned self] in
                
                let result = OperationResult<Element>.buildResult(self)
                
                // Workaround
                DispatchQueue.main.async {
                    
                    block(result)
                }
            }
        }
    }
    
    //
    // MARK: - Override
    deinit {
        self.error = nil
        self.response = nil
        self.baseCompletionBlock = nil
        self.completionBlock = nil
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
    override open var isAsynchronous: Bool {
        return true
    }
    
    /// Finish
    func finishOperation() {
        self.isExecuting = false
        self.isFinished = true
    }
    
    /// Main
    override open func main() {
        
        // Executing
        self.isExecuting = true;
        
        // Load data here -> Need override
        
    }
    
    //
    // MARK: - Public
    
    /// Failed
    func handleError(_ error: NSError?) {
        self.response = nil
        self.error = error
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

//
// MARK: - Healper
extension BaseOperation {
    
    func executeOnBackground(block: BaseOperationCompletionBlock? = nil) {
        
        // Copy block
        self.baseCompletionBlock = block
        
        // Execute on background
        QueueManager.shared.executeOperationOnBackgroundThread(self)
    }
}
