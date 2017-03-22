//
//  TableRowView.swift
//  Titan
//
//  Created by Nghia Tran on 2/3/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa

class TableRowView: NSTableRowView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.canDrawSubviewsIntoLayer = true
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func drawSelection(in dirtyRect: NSRect) {
        super.drawSelection(in: dirtyRect)
        
        NSColor(hexString: "#F4F5F9").setFill()
        NSRectFill(dirtyRect)
    }
}
