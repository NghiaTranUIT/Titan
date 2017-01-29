//
//  DetailConnectionInteractor.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol DetailConnectionInteractorOutput {
    func presentMainAppWithConnection(_ connection: DatabaseObj)
    func presentError(with error: NSError)
}

class DetailConnectionInteractor {
    
    //
    // MARK: - Variable
    var output: DetailConnectionInteractorOutput!
}

//
// MARK: - DetailConnectionInteractorInput
extension DetailConnectionInteractor: DetailConnectionsControllerOutput {
    
    func connectDatabase(_ databaseObj: DatabaseObj) {
        let worker = ConnectDatabaseWorker(databaseObj: databaseObj)
        worker
            .execute()
            .then { db in
                self.output.presentMainAppWithConnection(db)
            }
            .catch { error in
                self.output.presentError(with: error as NSError)
        }
    }
    
    func saveDatabaseObjToDisk(databaseObj: DatabaseObj) {
        let worker = SaveDatabaseObjToDiskWorker(databaseObj: databaseObj)
        worker.execute()
    }
}
