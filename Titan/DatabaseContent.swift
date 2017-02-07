//
//  DatabaseContent.swift
//  Titan
//
//  Created by Nghia Tran on 2/7/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation
import TitanKit

class DatabaseContent {
    
    //
    // MARK: - Variable
    fileprivate var table: Table!
    fileprivate var workerQueue: Queue<BaseAsyncWorker> = Queue<BaseAsyncWorker>()
    
    //
    // MARK: - Initializer
    init(table: Table) {
        self.table = table
    }
    
    //
    // MARK: - Public
    func firstPage() {
        
        // Cancel
        self.cancelAllWorker()
        
        //
    }
    
    
    //
    // MARK: - Pagination
    func nextPage() {
        
    }
    
    func previousPage() {
        
    }
}

//
// MARK: - Private
extension DatabaseContent {
    
    fileprivate func cancelAllWorker() {
        
    }
}
