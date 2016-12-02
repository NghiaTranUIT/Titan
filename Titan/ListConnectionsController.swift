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
    func fetchConnections()
    func selectConnection(_ connection: DatabaseObj)
    func addNewConnection()
}


//
// MARK: - Input
/// Input for ListController
/// Called from Presenter if ReduxStore has changed data
protocol ListConnectionsControllerInput: class {
    func reloadData()
}


//
// MARK: - DataSource
/// Contains main helper to get data source for collection View
/// Presenter will take responsibile for dataSource
protocol ListConnectionsControllerDataSource {
    func numberOfGroupConnections() -> Int
    func numberOfDatabase(at section: Int) -> Int
    func database(at indexPath: IndexPath) -> DatabaseObj
    func groupConnection(at indexPath: IndexPath) -> GroupConnectionObj
}


//
// MARK: - List Connection Controller
/// It will present all GroupConnection and all database
/// Will combine data from local and cloud (if user has already logged-in)
class ListConnectionsController: BaseViewController {

    //
    // MARK: - Variable
    var output: ListConnectionsControllerOutput!
    var dataSource: ListConnectionsControllerDataSource!
    
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var addConnectionBtn: NSButton!
    
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initCommon() {
        
        // Configure
        ListConnectionConfig.shared.configure(viewController: self)
        
        // Table View
        self.initTableView()
    }
    
    private func initTableView() {
        
        // Data Source
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // Register
        self.collectionView.registerCell(ConnectionCell.self)
        self.collectionView.registerSupplementary(ConnectionGroupCell.self, kind: NSCollectionElementKindSectionHeader)
        
        // Layout
        self.collectionView.enclosingScrollView?.contentInsets = NSEdgeInsetsMake(24, 0, 0, 0)
        
        // Flow layout
        let flowLayout = NSCollectionViewFlowLayout()
        let width = self.collectionView.frame.size.width
        flowLayout.itemSize = CGSize(width: width, height: 32)
        flowLayout.sectionInset = NSEdgeInsetsMake(0, 0, 20, 0)
        flowLayout.headerReferenceSize = CGSize(width: width, height: 36)
        flowLayout.sectionHeadersPinToVisibleBounds = false
        flowLayout.sectionFootersPinToVisibleBounds = false
    }
    
    override func setupActions() {
    
        // Fetch all connection
        self.output.fetchConnections()
    }
    
    @IBAction func addNewConnectionTapped(_ sender: NSButton) {
        self.output.addNewConnection()
    }
}

//
// MARK: - ViewModel Delegate
extension ListConnectionsController: ListConnectionsControllerInput {
    func reloadData() {
        self.collectionView.reloadData()
    }
}

//
// MARK: - Data Source
extension ListConnectionsController: NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return self.dataSource.numberOfGroupConnections()
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.numberOfDatabase(at: section)
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        // Database cell
        let databaseObj = self.dataSource.database(at: indexPath)
        return self.connectionCell(with: databaseObj, for: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> NSView {
        let groupConnection = self.dataSource.groupConnection(at: indexPath)
        return self.groupConnectionHeader(with: groupConnection, for: collectionView, indexPath: indexPath)
    }
}


//
// MARK: - Delegate
extension ListConnectionsController: NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
    
        // Select
        let selectedDb = self.dataSource.database(at: indexPaths.first!)
        self.output.selectConnection(selectedDb)
    }
}


//
// MARK: - Private
extension ListConnectionsController {
    
    fileprivate func connectionCell(with databaseObj: DatabaseObj, for collectionView: NSCollectionView, indexPath: IndexPath) -> NSCollectionViewItem {
        let cell = collectionView.makeItem(withIdentifier: ConnectionCell.identifierView, for: indexPath) as! ConnectionCell
        cell.configureCell(with: databaseObj)
        return cell
    }
    
    fileprivate func groupConnectionHeader(with groupConnectionObj: GroupConnectionObj, for collectionView: NSCollectionView, indexPath: IndexPath) -> NSView {
        let header = collectionView.makeSupplementaryView(ofKind: NSCollectionElementKindSectionHeader, withIdentifier: ConnectionGroupCell.identifierView, for: indexPath) as! ConnectionGroupCell
        header.configureCellWith(groupConnectionObj: groupConnectionObj)
        return header
    }
}
