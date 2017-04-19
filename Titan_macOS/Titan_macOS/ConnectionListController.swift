//
//  ConnectionListController.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/5/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore

class ConnectionListController: BaseViewController {

    //
    // MARK: - OUTLET
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var createGroupBtn: NSButton!
    
    //
    // MARK: - Variable
    fileprivate var dataSource: ConnectionListDataSource!
    fileprivate var viewModel: ConnectionListViewModel!
    
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
extension ConnectionListController {
    
    fileprivate func initCommon() {
        
    }
    
    fileprivate func initDataSource() {
        self.dataSource = ConnectionListDataSource(collectionView: self.collectionView)
        self.dataSource.delegate = self
    }
    
    fileprivate func initViewModel() {
        self.viewModel = ConnectionListViewModel()
    }
    
    fileprivate func binding() {
        
        // Reload data
        self.viewModel.groupConnectionsVariable
        .asDriver()
        .filter({ (groups) -> Bool in
            return groups.count > 0
        })
        .drive(onNext: { (_) in
            self.collectionView.reloadData()
        })
        .addDisposableTo(self.disposeBase)
        
        self.viewModel.reloadDataDriver
        .drive(onNext: { (_) in
            self.collectionView.reloadData()
        })
        .addDisposableTo(self.disposeBase)
        
        // Fetch connection
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.viewModel.input.fetchAllDatabasePublisher.onNext()
        }
        
        // Observe isLoading
        self.viewModel.output.isLoading.drive(onNext: { (isLoading) in
            Logger.info("isLoading = \(isLoading)")
        })
        .addDisposableTo(self.disposeBase)
        
        // Create new group
        self.createGroupBtn.rx.tap
        .bind(to: self.viewModel.input.createGroupDatabasePublisher)
        .addDisposableTo(self.disposeBase)
        
        // Create new database
        self.dataSource.createDatabasePublisher
        .bind(to: self.viewModel.input.createDatabaseInGroupPublisher)
        .addDisposableTo(self.disposeBase)
    }
}

//
// MARK: - CommonDataSourceProtocol
extension ConnectionListController: BaseCollectionViewDataSourceProtocol {

    // Number of item
    func CommonDataSourceNumberOfItem(at section: Int) -> Int {
        let groupObj = self.viewModel[section]
        return groupObj.databases.count
    }
    
    // Number of section
    func CommonDataSourceNumberOfSection() -> Int {
        return self.viewModel.count
    }
    
    // Item at index path
    func CommonDataSourceItem(at indexPath: IndexPath) -> BaseModel {
        return self.viewModel[indexPath.section]
    }
    
    /// Did selecte
    func didSelectItem(at indexPaths: Set<IndexPath>) {
        guard let indexPath = indexPaths.first else {return}
        
        self.viewModel.selectedDatabasePublisher.onNext(indexPath)
    }
}

