//
//  MainConnectionController.swift
//  Titan
//
//  Created by Nghia Tran on 10/26/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

class MainConnectionController: NSViewController {

    //
    // MARK: - Variable
    @IBOutlet weak var topBarView: NSView!
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Common
        self.initBaseAbility()
    }

    override func initCommon() {
        
        self.topBarView.backgroundColor = NSColor(hexString: "#9b59b6")
        // Want layer
        self.view.wantsLayer = true
        
    }
    
}


