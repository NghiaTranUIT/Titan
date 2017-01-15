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
}

protocol ListConnectionsControllerDataSource {
    func dataSourceForListConnection() -> ListConnectionDataSource
}


//
// MARK: - List Connection Controller
/// It will present all GroupConnection and all database
/// Will combine data from local and cloud (if user has already logged-in)
class ListConnectionsController: NSViewController {

    //
    // MARK: - Variable
    var output: ListConnectionsControllerOutput!
    var dataSource: ListConnectionsControllerDataSource!
    
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
    
    @IBAction func newGroupConnectionBtnTapped(_ sender: Any) {
        self.output.addNewConnection()
    }

}

//
// MARK: - ViewModel Delegate
extension ListConnectionsController: ListConnectionPresenterOutput {
    
    func didSelectedDatabase(_ databaseObj: DatabaseObj) {
        
        // Prepare Layout in Detail Connection 
        let userInfo: [String: Any] = ["selectedDatabase": databaseObj]
        NotificationManager.postNotificationOnMainThreadType(.prepareLayoutForSelectedDatabase, object: nil, userInfo: userInfo)
    }
    
    func handleError(_ error: NSError) {
        
    }
    
    func reloadData() {
        self.collectionView.reloadData()
    }
}


//
// MARK: - Private
extension ListConnectionsController {
    
    /// Collection View
    fileprivate func initCollectionView() {
        
        let dataSource = self.dataSource.dataSourceForListConnection()
        dataSource.setupCollectionView(self.collectionView)
    }
}
