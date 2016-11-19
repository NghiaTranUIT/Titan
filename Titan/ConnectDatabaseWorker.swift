//
//  ConnectDatabaseWorker.swift
//  Titan
//
//  Created by Nghia Tran on 11/18/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift

struct ConnectDatabaseAction: Action {
    var selectedDatabase: DatabaseObj!
}

class ConnectDatabaseWorker: AsyncWorker {

    var action: Action!
    
    required init() {
        
    }
    
    func execute(_ completionBlock: WorkerCompletionBlock?) {
        
    }
}
