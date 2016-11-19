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
        self.connectDBWorker.execute {[unowned self] (result) in
            switch result {
            case .Success(let db as DatabaseObj):
                self.output.presentMainAppWithConnection(db)
                break
            case .Failure(let error):
                self.output.presentError(with: error as NSError)
                break
            default:
                break
            }
        }
    }
}
