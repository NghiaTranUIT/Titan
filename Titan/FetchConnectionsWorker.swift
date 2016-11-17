//
//  FetchConnectionsWorker.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift

struct FetchConnectionsAction: Action {
    
}

class FetchConnectionsWorker: Worker {
    
    var action: Action!
    
    required init() {
        
    }
    
    func fetch(_ completionBlock: ([DatabaseObj])->()) {
        completionBlock([])
    }
}
