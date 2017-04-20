//
//  DetailDatabaseContainerController.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/19/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore

class DetailDatabaseContainerController: BaseViewController {

    //
    // MARK: - OUTLET
    @IBOutlet weak var topBarView: NSView!
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initCommon()
    }
    
}

//
// MARK: - Private
extension DetailDatabaseContainerController {
    
    fileprivate func initCommon() {
        self.topBarView.backgroundColor = NSColor(hexString: "#9b59b6")
    }
}
