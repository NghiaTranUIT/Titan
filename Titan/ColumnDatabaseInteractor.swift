//
//  ColumnDatabaseInteractor.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol ColumnDatabaseInteractorOutput {
    
}

class ColumnDatabaseInteractor {

    //
    // MARK: - Variable
    var output: ColumnDatabaseInteractorOutput?
}

//
// MARK: - ColumnDatabaseControllerOutput
extension ColumnDatabaseInteractor: ColumnDatabaseControllerOutput {
    
    func fetchColumnDatabaseInfo() {
        let selectedDb = mainStore.state.detailDatabaseState!.selectedConnection
        let worker = FetchColumnDatabaseInfoWorker(databaseObj: selectedDb!)
        worker.execute()
        .then { (_) -> Void in
            
        }
        .catch { error in
            
        }
    }
}
