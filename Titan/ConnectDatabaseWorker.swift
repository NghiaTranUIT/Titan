//
//  ConnectDatabaseWorker.swift
//  Titan
//
//  Created by Nghia Tran on 11/18/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift
import PromiseKit
import TitanKit

struct ConnectDatabaseAction: Action {
    var selectedDatabase: DatabaseObj!
}

class ConnectDatabaseWorker: AsyncWorker {

    typealias T = Void
    var databaseObj: DatabaseObj!
    
    init(databaseObj: DatabaseObj) {
        self.databaseObj = databaseObj
    }
    
    func execute() -> Promise<T> {
        return DatabaseManager.shared
        .openConnection(with: self.databaseObj)
        .then(execute: { _ -> Promise<T> in
            
        })
    }
}
