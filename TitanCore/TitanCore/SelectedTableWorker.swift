//
//  SelectedTableWorker.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/20/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import SwiftyPostgreSQL
import RxSwift

struct SelectedTableAction: Action {
    var selectedTable: Table!
    var replaceCurrentTable: Bool
    var storeType: StoreType {return .detailDatabaseStore}
}

struct AddSelectedTableToStackAction: Action {
    var selectedTable: Table!
    var storeType: StoreType {return .detailDatabaseStore}
}

class SelectedTableInCurrentTabWorker: SyncWorker {
    
    typealias T = Void
    var seletedTable: Table!
    
    init(seletedTable: Table) {
        self.seletedTable = seletedTable
    }
    
    func execute() {
        
        // If no selection -> add to stack
        if MainStore.globalStore.detailDatabaseStore.stackTables.value.count == 0 {
            let addStackAction = AddSelectedTableToStackAction(selectedTable: self.seletedTable)
            MainStore.dispatch(addStackAction)
        }
        
        // Select table
        let action = SelectedTableAction(selectedTable: self.seletedTable, replaceCurrentTable: true)
        MainStore.dispatch(action)
        
        // Push Changed
        //NotificationManager.postNotificationOnMainThreadType(.stackTableStateChanged, object: nil, userInfo: ["openInNewTap": openInNewTap])
    }
}
