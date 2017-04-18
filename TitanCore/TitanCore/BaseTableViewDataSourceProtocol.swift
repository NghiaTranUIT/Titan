//
//  BaseTableViewDataSourceProtocol.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/12/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation

//
// MARK: - TableView
public protocol BaseTableViewDataSourceProtocol: CommonDataSourceProtocol {
    
    // OPTIONAL
    // View for Table column at row
    func CommonDataSourceViewFor(_ tableColumn: NSTableColumn?, row: Int) -> NSView?
    
    // Row view for row
    func CommonDataSourceRowView(for row: Int) -> NSTableRowView?
    
    // Height for row
    func CommonDataSourceHeight(for row: Int) -> CGFloat
    
    // didSelect
    func CommonDataSourceDidSelectedRow(at indexPath: IndexPath)
    
}

//
// MARK: - Extension for Optional method
extension BaseTableViewDataSourceProtocol {
    
    func CommonDataSourceHeight(for row: Int) -> CGFloat {
        return 44.0
    }
    
    func CommonDataSourceDidSelectedRow(at indexPath: IndexPath) {
        // Do nothings
    }
    
    func CommonDataSourceRowView(for row: Int) -> NSTableRowView? {
        return nil
    }
    
    func CommonDataSourceViewFor(_ tableColumn: NSTableColumn?, row: Int) -> NSView? {
        return nil
    }
}
