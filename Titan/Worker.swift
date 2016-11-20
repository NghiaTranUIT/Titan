//
//  Worker.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift
import BrightFutures

//
// MARK: - Worker
protocol Worker {
    
    associatedtype T
    
    var action: Action! {get set}
    
    init()
}


//
// MARK: - Async Worker
protocol AsyncWorker: Worker {
    func execute() -> Future<T, NSError>
}


//
// MARK: - Sync Worker
protocol SyncWorker: Worker {
    func execute()
}


//
// MARK: - Extension Worker with Init method.
extension Worker {
    
    init(action: Action) {
        self.init()
        self.action = action
    }
}
