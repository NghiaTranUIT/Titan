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
    fileprivate var viewModel: MainConnectionViewModel!
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.setupBinding()
    }
}

//
// MARK: - Private
extension MainConnectionController {
    fileprivate func setupBinding() {
        
        // Init
        self.viewModel = MainConnectionViewModel()
        
        // Selected Connection
        
    }
}
