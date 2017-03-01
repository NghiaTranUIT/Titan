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
import SwiftyPostgreSQL

struct ConnectDatabaseAction: Action {
    var selectedDatabase: DatabaseObj!
}

class ConnectDatabaseWorker: AsyncWorker {

    typealias T = DatabaseObj
    var databaseObj: DatabaseObj!
    
    init(databaseObj: DatabaseObj) {
        self.databaseObj = databaseObj
    }
    
    func execute() -> Promise<T> {
        return DatabaseManager.shared
        .openConnection(with: self.databaseObj)
        .thenOnMainTheard(execute: { (_) -> Promise<T> in
            
            // Update state
            let action = ConnectDatabaseAction(selectedDatabase: self.databaseObj)
            mainStore.dispatch(action)
            
            return Promise<T>(value: self.databaseObj)
        })
    }
}
