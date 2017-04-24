//
//  Pagination.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/24/17.
//  Copyright © 2017 nghiatran. All rights reserved.
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
