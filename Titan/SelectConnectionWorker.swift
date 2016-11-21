//
//  SelectionConnectionWorker.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift

struct SelectConnectionAction: Action {
    var selectedConnection: DatabaseObj
}

class SelectConnectionWorker: SyncWorker {
    
    private var selectedDb: DatabaseObj!
    
    init(selectedDb: DatabaseObj) {
        self.selectedDb = selectedDb
    }
    func execute() {
        let action = SelectConnectionAction(selectedConnection: self.selectedDb)
        mainStore.dispatch(action)
    }
}
