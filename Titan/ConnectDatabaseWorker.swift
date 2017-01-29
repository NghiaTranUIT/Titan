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

    typealias T = DatabaseObj
    var databaseObj: DatabaseObj!
    
    init(databaseObj: DatabaseObj) {
        self.databaseObj = databaseObj
    }
    
    func execute() -> Promise<T> {
        
        let param = self.databaseObj.buildConnectionParam()
        
        return Promise(value: T())
    }
}
