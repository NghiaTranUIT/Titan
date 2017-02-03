//
//  DoubleTapTableWorker.swift
//  Titan
//
//  Created by Nghia Tran on 2/3/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import TitanKit
import ReSwift

class DoubleTapTableWorker: SyncWorker {
    
    typealias T = Void
    var seletedTable: Table!
    
    init(seletedTable: Table) {
        self.seletedTable = seletedTable
    }
    
    func execute() -> T {
        
        // Add to stack if need
        let addStackAction = AddSelectedTableToStackAction(selectedTable: self.seletedTable)
        mainStore.dispatch(addStackAction)
        NotificationManager.postNotificationOnMainThreadType(.stackTableStateChanged)
        
        // Select
        let action = SelectedTableAction(selectedTable: self.seletedTable)
        mainStore.dispatch(action)
        NotificationManager.postNotificationOnMainThreadType(.selectedTableStateChanged)
    }
}