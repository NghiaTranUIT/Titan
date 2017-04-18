//
//  DetailDatabaseController.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/11/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore

class DetailDatabaseController: BaseViewController {
    
    //
    // MARK: - Variable
    fileprivate var viewModel: ConnectionDetailViewModel!
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init
        self.initCommon()
        self.initViewModel()
        self.binding()
    }
    
    fileprivate func binding() {
        
        // Update layout if select database
        self.viewModel.output.selectedDatabaseObserver
        .subscribe(onNext: {[weak self] (databaseObj) in
            guard let `self` = self else {return}
            guard let databaseObj = databaseObj else {return}
            
            // Update layout
            self.updateLayout(with: databaseObj)
        })
        .addDisposableTo(self.disposeBase)
    }
}

//
// MARK: - Private
extension DetailDatabaseController {
    
    fileprivate func initCommon() {
        
    }
    
    fileprivate func initViewModel() {
        self.viewModel = ConnectionDetailViewModel()
    }
    
    fileprivate func updateLayout(with databaseObj: DatabaseObj) {
        
    }
}
