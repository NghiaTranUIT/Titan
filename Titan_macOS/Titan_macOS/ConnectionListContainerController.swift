//
//  ConnectionListContainerController.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/12/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore

class ConnectionListContainerController: BaseViewController {

    //
    // MARK: - OUTLET
    @IBOutlet weak var topBarView: NSView!
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init
        self.initCommon()
    }
    
}

//
// MARK: - Private
extension ConnectionListContainerController {
    
    fileprivate func initCommon() {
        self.topBarView.backgroundColor = NSColor(hexString: "#9b59b6")
        self.view.wantsLayer = true
    }
}
