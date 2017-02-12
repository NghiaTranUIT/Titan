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
    fileprivate var workerQueue: Queue<BaseAsyncWorker> = Queue<BaseAsyncWorker>()
    fileprivate var mode = GridContentViewMode.none
    fileprivate var currentQuery: PostgreQuery?
    fileprivate let pagination = Pagination()
    
    //
    // MARK: - Initializer
    
    //
    // MARK: - Public
    func configure(with mode: GridContentViewMode) {
        
        self.mode = mode
        
        switch self.mode {
        case .individually(let table):
            self.currentQuery = PostgreQuery.buildDefaultQuery(with: table, pagination: self.pagination)
            break
        case .dynamic:
            break
        case .none:
            break
        }
    }
    
    func query(_ query: PostgreQuery) {
        
    }
    
    func fetchFirstPage() {
        
        // Cancel
        self.cancelAllWorker()
        
        //
    }
    
    
    //
    // MARK: - Pagination
    func nextPage() {
        
        // Cancel
        self.cancelAllWorker()
        
    }
    
    func previousPage() {
        
        // Cancel
        self.cancelAllWorker()
        
    }
}

//
// MARK: - Private
extension DatabaseContent {
    
    fileprivate func cancelAllWorker() {
        
    }
}

