//
//  ListConnectionPresenter.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol ListConnectionPresenterInput: ListConnectionInteractorOutput {
    
}

class ListConnectionPresenter {

    //
    // MARK: - Variable
    weak var output: ListConnectionsControllerInput!
    fileprivate var connections: [DatabaseObj] = []
    
}

//
// MARK: - ListConnectionPresenterInput
extension ListConnectionPresenter: ListConnectionPresenterInput {
    func presentConnections(_ connections: [DatabaseObj]) {
        self.connections = connections
        self.output.displayConnections(connections)
    }
}

//
// MARK: - ListConnectionsControllerDataSource
extension ListConnectionPresenter: ListConnectionsControllerDataSource {
    func numberOfConnections() -> Int {
        return self.connections.count
    }
    
    func connection(at row: Int) -> DatabaseObj {
        return self.connections[row]
    }
}
