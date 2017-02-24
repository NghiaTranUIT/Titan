//
//  NSTableView+Column.swift
//  Titan
//
//  Created by Nghia Tran on 2/12/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation
import Cocoa

extension NSTableView {
    
    // Remove all columns
    func removeAllColumns() {
        while self.tableColumns.count > 0 {
            let tableColumn = self.tableColumns.last
            self.removeTableColumn(tableColumn!)
        }
    }
}
