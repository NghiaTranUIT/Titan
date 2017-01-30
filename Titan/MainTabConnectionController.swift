//
//  MainTabConnectionController.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

class MainTabConnectionController: NSViewController {

    //
    // MARK: - Variable
    
    //
    // MARK: - Outlet
    
    // Top bar
    @IBOutlet weak var topBarView: NSView!
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initBaseAbility()
    }
    
    override func initUIs() {
        self.topBarView.backgroundColor = NSColor(hexString: "#1799DD")
    }
}
