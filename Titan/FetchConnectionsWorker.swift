//
//  FetchConnectionsWorker.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift
import PromiseKit

struct FetchConnectionsAction: Action {
    
}

class FetchConnectionsWorker: AsyncWorker {
    
    typealias T = [DatabaseObj]
    
    var action: Action!
    
    required init() {
        
    }
    
    func execute() -> Promise<T> {
        return Promise(value: [])
    }
    
}
