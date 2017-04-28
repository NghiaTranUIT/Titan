//
//  DetailDatabaseSplitController.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/19/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore

class DetailDatabaseSplitController: BaseSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        // Size of divider
        self.splitView.setPosition(200, ofDividerAt: 0)
    }
}
