//
//  TableRowCell.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/20/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore
import SwiftyPostgreSQL

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
    }
    
    fileprivate func initCommon() {
        self.layer?.borderColor = NSColor.blue.cgColor
        self.layer?.cornerRadius = 5
    }
    
    override var backgroundStyle: NSBackgroundStyle {
        didSet {
            if self.backgroundStyle == .light {
                self.tableImageView.image = NSImage(named: "icon_column_table")
                self.tableTitleLbl.textColor = NSColor(hexString: "#8F949A")
            }
            else if self.backgroundStyle == .dark {
                self.tableImageView.image = NSImage(named: "icon_column_table_selected")
                self.tableTitleLbl.textColor = NSColor(hexString: "#3C4B52")
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
