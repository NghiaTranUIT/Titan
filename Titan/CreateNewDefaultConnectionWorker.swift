//
//  CreateNewDefaultConnectionWorker.swift
//  Titan
//
//  Created by Nghia Tran on 11/19/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift
import PromiseKit

struct AddNewDefaultConnectionAction: Action {
    var newConnection: DatabaseObj
}

class CreateNewDefaultConnectionWorker: AsyncWorker {

    typealias T = DatabaseObj
    
    func execute() -> Promise<T> {
        let defaultDb = DatabaseObj.defaultDatabase()
        let action = AddNewDefaultConnectionAction(newConnection: defaultDb)
        mainStore.dispatch(action)
        return Promise(value: T())
    }
}
