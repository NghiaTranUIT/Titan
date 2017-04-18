//
//  QueueManager.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/18/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation

open class QueueManager {
    
    /// Share instance
    static let shared = QueueManager()
    
    // API Queue
    fileprivate lazy var operationsQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 10
        queue.qualityOfService = QualityOfService.userInitiated
        queue.name = "com.fe.titan.backgroundOperationQueue"
        return queue
    }()
    
    // Main Queue
    fileprivate let mainQueue = OperationQueue.main
    
    //
    // MARK: - Public
    
    /// Stop all
    func stopAllRunningOperation() {
        self.operationsQueue.cancelAllOperations()
    }
    
    // Stop invidually operation
    func stopOperation<T>(with operation: BaseOperation<T>) {
        
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        
        // Stop
        _ = self.operationsQueue.operations.filter { (op) -> Bool in
            guard let op = op as? BaseOperation<T> else {return false}
            if op.uuid == operation.uuid {
                Logger.debug("Stoped operation \(op.uuid)")
                op.cancel()
                return true
            }
            return false
        }
    }
    
    /// Run operation on main thread
    func executeOperationOnMainThread<T>(_ op: BaseOperation<T>) {
        self.mainQueue.addOperation(op)
    }
    
    /// Run on operation thread
    func executeOperationOnBackgroundThread<T>(_ op: BaseOperation<T>) {
        self.operationsQueue.addOperation(op)
    }

}
