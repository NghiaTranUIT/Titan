//
//  ContentRowView.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/24/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa

class ContentRowView: NSTableRowView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.canDrawSubviewsIntoLayer = true
    }
    
}
