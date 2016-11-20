//
//  ConnectDatabaseWorker.swift
//  Titan
//
//  Created by Nghia Tran on 11/18/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift
import BrightFutures

struct ConnectDatabaseAction: Action {
    var selectedDatabase: DatabaseObj!
}

class ConnectDatabaseWorker: AsyncWorker {

    typealias T = DatabaseObj
    
    var action: Action!
    
    required init() {
        
    }
    
    func execute() -> Future<T, NSError> {
        return Future(error: NSError.unknowError())
    }
}
