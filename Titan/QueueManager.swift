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
    
}

//
// MARK: - Private
extension QueueManager {

}
