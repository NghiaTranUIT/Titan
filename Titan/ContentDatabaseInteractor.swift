//
//  DataDatabaseInteractor.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import SwiftyPostgreSQL

protocol ContentDatabaseInteractorOutput {
    
}

class ContentDatabaseInteractor {

    //
    // MARK: - Variable
    var output: ContentDatabaseInteractorOutput?
}

//
// MARK: - ContentDatabaseControllerOutput
extension ContentDatabaseInteractor: ContentDatabaseControllerOutput {
    
    // Switch Tab
    func didSwitchTab(with table: Table) {
        let worker = SelectedTableInCurrentTabWorker(seletedTable: table)
        worker.execute()
    }
}
