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

//
// MARK: - Action
struct FetchAllGroupConnectionsAction: Action {
    var connections: [GroupConnectionObj]
}


//
// MARK: - Worker
class FetchAllGroupConnectionsWorker: AsyncWorker {
    
    
    /// Type
    typealias T = [GroupConnectionObj]
    
    
    /// Execute
    func execute() -> Promise<T> {
        return RealmManager.sharedManager
            .fetchAll(type: GroupConnectionRealmObj.self)
            .then { (results) -> Promise<T> in
                var groups: T = T()
                for group in results {
                    groups.append(group.convertToModelObj())
                }
                return Promise(value: groups)
        }
        .then(execute: { (groups) -> Promise<T> in
            let action = FetchAllGroupConnectionsAction(connections: groups)
            mainStore.dispatch(action)
            return Promise(value: groups)
        })
    }
}
