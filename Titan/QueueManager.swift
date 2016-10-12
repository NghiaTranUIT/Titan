//
//  QueueManager.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

class QueueManager {
    
    // Share instance
    static let shared = QueueManager()
    
    // Main queue
    static let mainQueue: OperationQueue = {
       return OperationQueue.main
    }()
    
    // Background queue
    static let backgroundQueue: OperationQueue = {
       let backgroundQueue = OperationQueue()
        backgroundQueue.maxConcurrentOperationCount = 5
        backgroundQueue.name = "com.fe.titan.backgroundqueue"
        backgroundQueue.qualityOfService = .background
        return backgroundQueue
    }()
}

//
// MARK: - Queue execution helpers
extension QueueManager {
    
    func enqueueOnBackground(operations: [BaseOperation], block: @escaping ResponseBlock) {
        guard operations.count > 0 else {
            return
        }
        
        // UI Operation - run on main thread
        let uiOp = UpdateUIOperation(block: block)
        
        // Dependency
        let lastOp = operations.last!
        uiOp.addDependency(lastOp)
        
        // Queue
        QueueManager.backgroundQueue.addOperations(operations, waitUntilFinished: false)
        QueueManager.mainQueue.addOperation(uiOp)
    }
    
}

//
// MARK: - Private
extension QueueManager {

}
