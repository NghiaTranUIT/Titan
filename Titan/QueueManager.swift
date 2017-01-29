//
//  QueueManager.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

class QueueManager {
    
    /// Share instance
    static let shared = QueueManager()
    
    // API Queue
    fileprivate lazy var apiQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 10
        queue.name = "com.fe.titan.backgroundQueue"
        return queue
    }()
    
    // Main Queue
    fileprivate let mainQueue = OperationQueue.main
    
    //
    // MARK: - Execute
    func enqueueOperation(_ op: BaseOperation, response responseBlock: @escaping ResponseBlock) {
        self.excuteOperation(op, responseBlock: responseBlock)
    }
    
    func stopAllRunningOperation() {
        self.apiQueue.cancelAllOperations()
    }
    
    func stopOperation(with uuid: String) {
        
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        
        // Stop
        for op in self.apiQueue.operations {
            guard let op = op as? BaseOperation else {
                continue
            }
            if op.uuid == uuid {
                Logger.debug("Stoped operation \(op.uuid)")
                op.cancel()
            }
        }
    }
    
    func executeOperationOnMainThread(_ op: BaseOperation) {
        self.mainQueue.addOperation(op)
    }
    
    //
    // MARK: - Private
    fileprivate func excuteOperation(_ op: BaseOperation, responseBlock: @escaping ResponseBlock) {
        let uiOp = UpdateUIOperation(updateBlock: responseBlock)
        
        // Dependency
        uiOp.addDependency(op)
        
        // Queue
        self.apiQueue.addOperation(op)
        self.mainQueue.addOperation(uiOp)
    }
}

//
// MARK: - Healper
extension BaseOperation {
    
    func executeOnBackground(with responseBlock: @escaping ResponseBlock) {
        QueueManager.shared.enqueueOperation(self, response: responseBlock)
    }
}
