//
//  ContentDatabaseController.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/19/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore

class ContentDatabaseController: BaseViewController {

    //
    // MARK: - Variable
    fileprivate var viewModel: ContentDatabaseViewModel!
    
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initCommon()
        self.initDataSource()
        self.initViewModel()
        self.binding()
    }
    
}

//
// MARK: - Private
extension ContentDatabaseController {
    
    fileprivate func initCommon() {
        
    }
    
    fileprivate func initDataSource() {
    }
    
    fileprivate func initViewModel() {
        self.viewModel = ContentDatabaseViewModel()
    }
    
    fileprivate func binding() {
        
        // Reload
        self.viewModel.output.reloadDatabaseContentDriver.drive(onNext: { _ in
            
        }).addDisposableTo(self.disposeBase)
    }
}
