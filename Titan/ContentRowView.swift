//
//  ContentRowView.swift
//  Titan
//
//  Created by Nghia Tran on 3/2/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa

class ContentRowView: NSTableRowView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.canDrawSubviewsIntoLayer = true
    }
    
}
