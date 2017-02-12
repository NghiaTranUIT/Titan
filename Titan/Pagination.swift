//
//  QueryPagination.swift
//  Titan
//
//  Created by Nghia Tran on 2/12/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation

class Pagination {
    
    //
    // MARK: - Variable
    var currentPage = 0
    var skip: Int {
        return self.currentPage * self.limit
    }
    lazy var limit: Int = {
       return AppPreferences.shared.defaultLimitQuery
    }()
    
    //
    // MARK: - Public
}
