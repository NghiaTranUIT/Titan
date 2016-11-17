//
//  BaseViewController.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

class BaseViewController: NSViewController {
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initCommon()
        
        self.setupBinding()
        
        self.setupActions()
    }
    
    
    /// All common things
    func initCommon() {
        // Do Nothing
    }
    
    func setupBinding() {
        // Do nothing
    }
    
    
    /// Setup all action heres
    func setupActions() {
        // Do nothing
    }
}
