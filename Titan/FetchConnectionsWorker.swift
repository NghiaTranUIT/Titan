//
//  FetchConnectionsWorker.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift
import BrightFutures

struct FetchConnectionsAction: Action {
    
}

class FetchConnectionsWorker: AsyncWorker {
    
    typealias T = [DatabaseObj]
    
    var action: Action!
    
    required init() {
        
    }
    
    func execute() -> Future<Array<DatabaseObj>, NSError> {
        return Future(value: [])
    }
    
}
