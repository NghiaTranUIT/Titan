//
//  DetailConnectionController.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

class DetailSplitConnectionController: BaseSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Base
        self.initBaseAbility()
    }
    
    override func initCommon() {
        self.view.wantsLayer = true
    }
    
}
