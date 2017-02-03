//
//  FetchColumnDatabaseInfoWorker.swift
//  Titan
//
//  Created by Nghia Tran on 2/3/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import PromiseKit
import ReSwift
import TitanKit

struct UpdateTablesInfoAction: Action {
    var tables: [Table] = []
}

class FetchColumnDatabaseInfoWorker: AsyncWorker {
    
    typealias T = Void
    var databaseObj: DatabaseObj!
    
    init(databaseObj: DatabaseObj) {
        self.databaseObj = databaseObj
    }
    
    func execute() -> Promise<T> {
        return DatabaseManager.shared.fetchTableInformation()
        .thenOnMainTheard(execute: { (tables) -> Promise<T> in
            
            // Action
            let action = UpdateTablesInfoAction(tables: tables)
            mainStore.dispatch(action)
            
            return Promise<Void>(resolvers: { (fullfill, reject) in
                fullfill()
            })
        })
    }
}
