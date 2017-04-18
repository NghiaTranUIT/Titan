//
//  BaseSplitViewController.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/5/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa

open class BaseSplitViewController: NSSplitViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Init
        self.initCommon()
    }
    
}

//
// MARK: - Private
extension BaseSplitViewController {
    
    fileprivate func initCommon() {
        self.view.wantsLayer = true
    }
}
