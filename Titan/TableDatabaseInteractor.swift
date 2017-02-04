//
//  ColumnDatabaseInteractor.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import TitanKit

protocol TableDatabaseInteractorOutput {
    
}

class TableDatabaseInteractor {

    //
    // MARK: - Variable
    var output: TableDatabaseInteractorOutput?
}

//
// MARK: - ColumnDatabaseControllerOutput
extension TableDatabaseInteractor: TableDatabaseControllerOutput {
    
    func fetchTablesDatabaseInfo() {
        
        let selectedDb = mainStore.state.detailDatabaseState!.selectedConnection
        let worker = FetchTableDatabaseInfoWorker(databaseObj: selectedDb!)
        worker.execute()
        .then { (_) -> Void in
            
        }
        .catch { error in
            
        }
    }
    
    func didSelectTable(_ table: Table) {
        let worker = SelectedTableWorker(seletedTable: table)
        worker.execute()
    }
    
    func didDoubleTapTable(_ table: Table) {
        let worker = DoubleTapTableWorker(seletedTable: table)
        worker.execute()
    }
}
