//
//  GridDatabaseView.swift
//  Titan
//
//  Created by Nghia Tran on 1/29/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import TitanKit

class GridDatabaseView: NSView {

    //
    // MARK: - Variable
    fileprivate var _table: Table!
    var table: Table {
        return _table
    }
    
    //
    // MARK: - View Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Base
        self.initBaseAbility()
    }
    
    
    //
    // MARK: - Public
    func configureGrid(with table: Table) {
        self._table = table
    }
}
