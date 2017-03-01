//
//  StackTableCell.swift
//  Titan
//
//  Created by Nghia Tran on 2/3/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import SwiftyPostgreSQL

protocol StackTableCellDelegate: class {
    func StackTableCellDidSelectTable(_ table: Table)
}

class StackTableCell: NSCollectionViewItem {

    //
    // MARK: - Variable
    weak var delegate: StackTableCellDelegate?
    fileprivate var table: Table?
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var tableImageView: NSImageView!
    @IBOutlet weak var tableTitleLbl: NSTextField!
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override var isSelected: Bool {
        didSet {
            self.tableTitleLbl.textColor = isSelected ? NSColor(hexString: "#2D2E30") : NSColor(hexString: "#8F9498")
            self.tableImageView.image = isSelected ? NSImage(named: "icon_stack_table_selected") : NSImage(named: "icon_stack_table")
        }
    }
    
    func configureCell(with table: Table, isSelected: Bool = false) {
        self.table = table
        self.tableTitleLbl.stringValue = table.tableName!
        self.isSelected = isSelected
    }
    
    @IBAction func actionBtnTapped(_ sender: Any) {
        guard self.isSelected == false else {return}
        guard let table = self.table else {return}
        
        self.delegate?.StackTableCellDidSelectTable(table)
    }
}
