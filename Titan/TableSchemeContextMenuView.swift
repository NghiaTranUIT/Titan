//
//  TableSchemeContextMenuView.swift
//  Titan
//
//  Created by Nghia Tran on 2/5/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import SwiftyPostgreSQL

protocol TableSchemeContextMenuViewDelegate: class {
    func TableSchemeContextMenuViewDidTapAction(_ action: TableSchemmaContextAction, table: Table)
}

//
// MARK: - Action
enum TableSchemmaContextAction {
    case openNewtab
    case copyTableName
    case truncate
    case delete
}

class TableSchemeContextMenuView: NSMenu {
    
    //
    // MARK: - Variable
    weak var contextDelegate: TableSchemeContextMenuViewDelegate?
    weak var currentItem: Table?
    weak var selectedRow: TableRowCell?
    
    //
    // MARK: - Public
    func configureContextView(with table: Table, selectedRow: TableRowCell) {
        self.currentItem = table
        self.selectedRow = selectedRow
    }
    
    //
    // MARK: - OUTLET
    @IBAction func openInNewTapBtnTapped(_ sender: Any) {
        guard let table = self.currentItem else {return}
        self.contextDelegate?.TableSchemeContextMenuViewDidTapAction(.openNewtab, table: table)
    }
    
    @IBAction func copyNameBtnTapped(_ sender: Any) {
        guard let table = self.currentItem else {return}
        self.contextDelegate?.TableSchemeContextMenuViewDidTapAction(.copyTableName, table: table)
    }
    
    @IBAction func truncateTableBtnTapped(_ sender: Any) {
        guard let table = self.currentItem else {return}
        self.contextDelegate?.TableSchemeContextMenuViewDidTapAction(.truncate, table: table)
    }
    
    @IBAction func deleteTableBtnTapped(_ sender: Any) {
        guard let table = self.currentItem else {return}
        self.contextDelegate?.TableSchemeContextMenuViewDidTapAction(.delete, table: table)
    }
}

//
// MARK: - XIBInitializable
extension TableSchemeContextMenuView: XIBInitializable {
    typealias T = TableSchemeContextMenuView
}
