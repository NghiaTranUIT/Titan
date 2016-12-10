//
//  BaseViewController.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa


extension NSViewController {
    
    //
    // MARK: - View Cycle
    open func viewDidLoad() {
        self.viewDidLoad()
        
        self.initCommon()
        
        self.initBinding()
        
        self.initActions()
    }
    
    override open func view(_ view: NSView, stringForToolTip tag: NSToolTipTag, point: NSPoint, userData data: UnsafeMutableRawPointer?) -> String {
        
    }
}


extension NSViewController: BaseAbility {
    
    /// Do common things here
    func initCommon() {}
    
    
    /// Do UIs things here
    func initAppearance() {}
    
    func initBinding() {}
    
    func initActions() {}
}
