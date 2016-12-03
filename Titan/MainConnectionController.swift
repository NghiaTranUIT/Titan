//
//  MainConnectionController.swift
//  Titan
//
//  Created by Nghia Tran on 10/26/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

class MainConnectionController: BaseSplitViewController {

    //
    // MARK: - Variable
    
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Common
        self.initCommon()
    }
    
    //
    // MARK: - Private
    private func initCommon() {
        
        // Want layer
        self.view.wantsLayer = true
        self.splitView.wantsLayer = true
    }
    
}


