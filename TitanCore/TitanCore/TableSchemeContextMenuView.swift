//
//  TableSchemeContextMenuView.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/24/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import SwiftyPostgreSQL

public protocol TableSchemeContextMenuViewDelegate: class {
    func TableSchemeContextMenuViewDidTapAction(_ action: TableSchemmaContextAction, table: Table)
}

//
// MARK: - Action
public enum TableSchemmaContextAction {
    case openNewtab
    case copyTableName
    case truncate
    case delete
}

open class TableSchemeContextMenuView: NSMenu {
    
    //
    // MARK: - Variable
    public weak var contextDelegate: TableSchemeContextMenuViewDelegate?
    public weak var currentItem: Table?
    public weak var selectedRow: TableRowCell?
    
    //
    // MARK: - Public
    public func configureContextView(with table: Table, selectedRow: TableRowCell) {
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
    public typealias T = TableSchemeContextMenuView
}
