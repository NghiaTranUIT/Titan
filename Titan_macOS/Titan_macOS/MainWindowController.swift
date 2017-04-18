//
//  MainWindowController.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/11/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore

class MainWindowController: MacBaseWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        
    }
    
    deinit {
        Logger.debug("List connection window DEINIT")
    }
}
