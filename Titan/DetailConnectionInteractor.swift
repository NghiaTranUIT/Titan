//
//  DetailConnectionInteractor.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol DetailConnectionInteractorInput: DetailConnectionsControllerOutput {
    
}

protocol DetailConnectionInteractorOutput {
    func presentMainAppWithConnection(_ connection: DatabaseObj)
    func presentError(with error: NSError)
}

class DetailConnectionInteractor {
    
    //
    // MARK: - Variable
    var output: DetailConnectionInteractorOutput!
    var connectDBWorker: ConnectDatabaseWorker!
}


//
// MARK: - DetailConnectionInteractorInput
extension DetailConnectionInteractor: DetailConnectionInteractorInput {
    func connectConnection(_ connection: DatabaseObj) {
        let action = ConnectDatabaseAction(selectedDatabase: connection)
        self.connectDBWorker = ConnectDatabaseWorker(action: action)
        self.connectDBWorker.execute().onSuccess { db in
            self.output.presentMainAppWithConnection(db)
        }.onFailure { (error) in
            self.output.presentError(with: error as NSError)
        }
    }
}
