//
//  ColumnDatabaseRowCel.swift
//  Titan
//
//  Created by Nghia Tran on 2/3/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import TitanKit

class TableRowCell: NSTableCellView {

    //
    // MARK: - Variable
    var table: Table?
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var tableImageView: NSImageView!
    @IBOutlet weak var tableTitleLbl: NSTextField!
    
    //
    // MARK: - View Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Base
        self.initBaseAbility()
    }
    
    override func initCommon() {
        self.layer?.borderColor = NSColor.blue.cgColor
        self.layer?.cornerRadius = 5
    }
    
    override var backgroundStyle: NSBackgroundStyle {
        didSet {
            if self.backgroundStyle == .light {
                self.tableImageView.image = NSImage(named: "icon_column_table")
                self.tableTitleLbl.textColor = NSColor(hexString: "#8F949A")
                self.tableTitleLbl.font = GlobalFont.font(.regular, size: 13)
            }
            else if self.backgroundStyle == .dark {
                self.tableImageView.image = NSImage(named: "icon_column_table_selected")
                self.tableTitleLbl.textColor = NSColor(hexString: "#3C4B52")
                self.tableTitleLbl.font = GlobalFont.font(.bold, size: 13)
            }
        }
    }
    
    //
    // MARK: - Public
    func configureCell(with table: Table) {
        self.table = table
        self.setupData()
    }
    
    func updateRightClickState(isHover: Bool = true) {
        self.layer?.borderWidth = isHover ? 1 : 0
    }
}

//
// MARK: - Private
extension TableRowCell {
    
    fileprivate func setupData() {
        guard let table = self.table else {return}
        
        self.tableTitleLbl.stringValue = table.tableName ?? "Unknow"
        self.layer?.borderWidth = 0
    }
}
