//
//  MainConnectionController.swift
//  Titan
//
//  Created by Nghia Tran on 10/26/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

enum ConnectionControllerIndex: Int {
    case listConnections = 0
    case detailConnection = 1
}

class MainConnectionController: BaseSplitViewController {

    //
    // MARK: - OUTLET
    
    // List Connection Controller
    fileprivate weak var listConnectionController: ListConnectionsController! {
        get {
            let index = ConnectionControllerIndex.listConnections.rawValue
            return self.splitViewItems[index].viewController as! ListConnectionsController
        }
    }
    
    // Detail Connection Controller
    fileprivate weak var detailConnectionController: DetailConnectionsController! {
        get {
            let index = ConnectionControllerIndex.detailConnection.rawValue
            return self.splitViewItems[index].viewController as! DetailConnectionsController
        }
    }
    
    //
    // MARK: - Variable
    fileprivate let viewModel = MainConnectionViewModel()
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Binding
        self.setupBinding()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        // Active
        self.viewModel.active = true
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        
        // Inactive
        self.viewModel.active = false
    }
}

//
// MARK: - Private
extension MainConnectionController {
    fileprivate func setupBinding() {
        
        // Delegate
        self.viewModel.dataSource = self
    }
}

//
// MARK: - Main Connection View model Data Source 
extension MainConnectionController: MainConnectionViewModelDataSource {
    func GetListConnectionModel(sender: MainConnectionViewModel) -> ListConnectionViewModel {
        return self.listConnectionController.viewModel
    }
    
    func GetDetailConnectionModel(sender: MainConnectionViewModel) -> DetailConnectionViewModel {
        return self.detailConnectionController.viewModel
    }
}
