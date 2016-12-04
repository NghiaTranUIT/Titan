//
//  SelectionConnectionWorker.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift

//
// MARK: - Action
struct SelectConnectionAction: Action {
    var selectedConnection: DatabaseObj
}


//
// MARK: - Worker
class SelectConnectionWorker: SyncWorker {
    
    
    /// Type
    private var selectedDb: DatabaseObj!
    
    
    /// Init
    init(selectedDb: DatabaseObj) {
        self.selectedDb = selectedDb
    }
    
    
    /// Execute
    func execute() {
        let action = SelectConnectionAction(selectedConnection: self.selectedDb)
        mainStore.dispatch(action)
    }
}
