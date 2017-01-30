//
//  ListConnectionsViewController.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift


//
// MARK: - Output
/// Send request to Interactor
protocol ListConnectionsControllerOutput {
    func fetchAllConnections()
    func selectConnection(_ connection: DatabaseObj)
    func addNewConnection()
    func createDatabaseIntoGroupObj(_ groupObj: GroupConnectionObj)
}

//
// MARK: - List Connection Controller
/// It will present all GroupConnection and all database
/// Will combine data from local and cloud (if user has already logged-in)
class ListConnectionsController: NSViewController {

    //
    // MARK: - Variable
    var output: ListConnectionsControllerOutput!
    fileprivate lazy var dataSource: GroupDatabaseDataSource! = {
        let data = GroupDatabaseDataSource()
        data.delegate = self
        return data
    }()
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var logoBigContainerView: NSView!
    @IBOutlet weak var logoContainerView: NSView!
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Base Ability
        self.initBaseAbility()
    }
    
    override func initCommon() {
        
        // Configure
        ListConnectionConfig.shared.configure(viewController: self)
        
        // Collection View
        self.initCollectionView()
    }
    
    override func initUIs() {
        
        // Background color
        self.view.backgroundColor = NSColor.white
        self.logoContainerView.backgroundColor = NSColor(hexString: "#1799DD")
        self.logoBigContainerView.backgroundColor = NSColor(hexString: "#1799DD")
        self.collectionView.backgroundColors = [NSColor.white]
        
        // Remove border
        self.collectionView.wantsLayer = true
        self.collectionView.layer?.borderWidth = 0
    }
    
    override func initActions() {
    
        // Fetch all connection
        self.output.fetchAllConnections()
    }
    
    @IBAction func newDatabaseBtnTapped(_ sender: Any) {
        self.output.addNewConnection()
    }
}

//
// MARK: - ViewModel Delegate
extension ListConnectionsController: ListConnectionPresenterOutput {
    
    func handleError(_ error: NSError) {
        
    }
    
    func shouldSelectCellWithDatabase(_ databaseObj: DatabaseObj) {
        self.dataSource.trySelectCellWithDatabaseObj(databaseObj)
    }
}


//
// MARK: - Private
extension ListConnectionsController {
    
    fileprivate func initCollectionView() {
        self.dataSource.collectionView = self.collectionView
    }
}

//
// MARK: - Data Source Delegate
extension ListConnectionsController: GroupDatabaseDataSourceDelegate {
    func GroupDatabaseDataSourceCreateNewDatabaseIntoGroup(_ group: GroupConnectionObj) {
        self.output.createDatabaseIntoGroupObj(group)
    }
    
    func GroupDatabaseDataSourceSaveDatabase(_ databaseObj: DatabaseObj) {
        NotificationManager.postNotificationOnMainThreadType(.saveCurrentDatabaseObj, object: databaseObj, userInfo: nil)
    }
}
