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

struct ReplaceTableAction: Action {
    var selectedTable: Table!
    var storeType: StoreType {return .detailDatabaseStore}
}

struct SelectedIndexInStackViewAction: Action {
    var selectedIndex: Int!
    var storeType: StoreType {return .detailDatabaseStore}
}

struct AddTableToStackAction: Action {
    var selectedTable: Table!
    var storeType: StoreType {return .detailDatabaseStore}
}

class ReplaceTableInCurrentTabWorker: SyncWorker {
    
    typealias T = Void
    var seletedTable: Table!
    
    init(seletedTable: Table) {
        self.seletedTable = seletedTable
    }
    
    func execute() {
        
        // If no selection -> add to stack
        if MainStore.globalStore.detailDatabaseStore.stackTables.value.count == 0 {
            let addStackAction = AddTableToStackAction(selectedTable: self.seletedTable)
            MainStore.dispatch(addStackAction)
        }
        else {
            // REplace table
            let action = ReplaceTableAction(selectedTable: self.seletedTable)
            MainStore.dispatch(action)
        }
    }
}
