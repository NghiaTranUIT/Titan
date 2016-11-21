//
//  Worker.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift
import PromiseKit

//
// MARK: - Worker
protocol Worker {
    
}


//
// MARK: - Async Worker
protocol AsyncWorker: Worker {
    
    associatedtype T
    
    func execute() -> Promise<T>
}


//
// MARK: - Sync Worker
protocol SyncWorker: Worker {
    func execute()
}
