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
    var connections: [DatabaseObj]
}

class FetchConnectionsWorker: AsyncWorker {
    
    typealias T = [DatabaseObj]
    
    func execute() -> Promise<T> {
        return RealmManager.sharedManager.fetchAll(type: DatabaseRealmObj.self)
            .then { (results) -> Promise<T> in
                var dbs: T = T()
                for db in results {
                    dbs.append(DatabaseObj.fromDatabaseRealmObj(db))
                }
                return Promise(value: dbs)
        }
        .then(execute: { (dbs) -> Promise<T> in
            let action = FetchConnectionsAction(connections: dbs)
            mainStore.dispatch(action)
            return Promise(value: dbs)
        })
    }
}
