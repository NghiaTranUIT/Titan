//
//  OpenTableInNewTabWorker.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/20/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import SwiftyPostgreSQL

class OpenTableInNewTabWorker: SyncWorker {
    
    typealias T = Void
    var seletedTable: Table!
    
    init(seletedTable: Table) {
        self.seletedTable = seletedTable
    }
    
    func execute() {
        
        // Add to stack and select
        let addStackAction = AddTableToStackAction(selectedTable: self.seletedTable)
        MainStore.dispatch(addStackAction)
    }
    
}
