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
protocol Worker: Equatable {
    
    var id: String {get}
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
    
    associatedtype T
    
    func execute() -> T
}

//
// MARK: - Default Worker
extension Worker {
    
    var id: String {
        return UUID.shortUUID()
    }
}

//
// MARK: - Equatable
extension Worker {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
