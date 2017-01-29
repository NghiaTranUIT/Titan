//
//  GroupDatabaseDataSource.swift
//  Titan
//
//  Created by Nghia Tran on 1/7/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import RealmSwift

protocol GroupDatabaseDataSourceDelegate: class {
    func GroupDatabaseDataSourceCreateNewDatabaseIntoGroup(_ group: GroupConnectionObj)
}

class GroupDatabaseDataSource: NSObject {
    
    //
    // MARK: - Variable
    weak var delegate: GroupDatabaseDataSourceDelegate?
    var collectionView: NSCollectionView! {didSet{self.setupCollectionView()}}
    var groupConnections: List<GroupConnectionObj> {
        return mainStore.state.connectionState!.groupConnections
    }
    
    //
    // MARK: - Init
    override init() {
        super.init()
        self.initCommon()
    }
    
    deinit {
        NotificationManager.removeAllObserve(self)
    }
    
    /// Obserable
    fileprivate func initCommon() {
        NotificationManager.observeNotificationType(.groupConnectionChanged, observer: self, selector: #selector(self.connectionStateChange), object: nil)
    }
    
    func setupCollectionView() {
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // Register
        self.collectionView.registerCell(ConnectionCell.self)
        self.collectionView.registerSupplementary(ConnectionGroupCell.self, kind: NSCollectionElementKindSectionHeader)
        
        // Flow layout
        let flowLayout = NSCollectionViewFlowLayout()
        let width = collectionView.frame.size.width
        flowLayout.itemSize = CGSize(width: 250, height: 31)
        flowLayout.sectionInset = NSEdgeInsetsMake(0, 0, 6, 0)
        flowLayout.headerReferenceSize = CGSize(width: width, height: 31)
        flowLayout.sectionHeadersPinToVisibleBounds = false
        flowLayout.sectionFootersPinToVisibleBounds = false
        self.collectionView.collectionViewLayout = flowLayout
        
        // Reload
        self.collectionView.reloadData()
    }

}

//
// MARK: - Private
extension GroupDatabaseDataSource {
    
    /// Database cell
    fileprivate func connectionCell(with databaseObj: DatabaseObj, for collectionView: NSCollectionView, indexPath: IndexPath) -> NSCollectionViewItem {
        let cell = collectionView.makeItem(withIdentifier: ConnectionCell.identifierView, for: indexPath) as! ConnectionCell
        cell.delegate = self
        cell.configureCell(with: databaseObj)
        return cell
    }
    
    
    /// Group Connection header
    fileprivate func groupConnectionHeader(with groupConnectionObj: GroupConnectionObj, for collectionView: NSCollectionView, indexPath: IndexPath) -> NSView {
        let header = collectionView.makeSupplementaryView(ofKind: NSCollectionElementKindSectionHeader, withIdentifier: ConnectionGroupCell.identifierView, for: indexPath) as! ConnectionGroupCell
        header.configureCellWith(groupConnectionObj: groupConnectionObj)
        header.delegate = self
        return header
    }
    
    fileprivate func selectedDatabase(_ databaseObj: DatabaseObj) {
        let worker = SelectConnectionWorker(selectedDb: databaseObj)
        worker.execute()
    }
    
    @objc fileprivate func connectionStateChange() {
        self.collectionView.reloadData()
    }
}

//
// MARK: - Collection View Data Source
extension GroupDatabaseDataSource: NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        let count = self.groupConnections.count
        return count
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = self.groupConnections[section]
        return group.databases.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        // Database cell
        let group = self.groupConnections[indexPath.section]
        let databaseObj = group.databases[indexPath.item]
        return self.connectionCell(with: databaseObj, for: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> NSView {
        let group = self.groupConnections[indexPath.section]
        return self.groupConnectionHeader(with: group, for: collectionView, indexPath: indexPath)
    }
}

//
// MARK: - Collection View Delegate
extension GroupDatabaseDataSource: NSCollectionViewDelegate {
    
    /// Did Select
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        
        guard let indexPath = indexPaths.first else {return}
        
        // Select
        let group = self.groupConnections[indexPath.section]
        let databaseObj = group.databases[indexPath.item]
        self.selectedDatabase(databaseObj)
    }
}

//
// MARK: - ConnectionCellDelegate
extension GroupDatabaseDataSource: ConnectionCellDelegate {
    func ConnectionCellDidSelectedCell(sender: ConnectionCell, databaseObj: DatabaseObj, isSelected: Bool) {
        self.selectedDatabase(databaseObj)
    }
}

extension GroupDatabaseDataSource: ConnectionGroupCellDelegate {
    func ConnectionGroupCellShouldCreateNewDatabaseWithGroup(group: GroupConnectionObj) {
        self.delegate?.GroupDatabaseDataSourceCreateNewDatabaseIntoGroup(group)
    }
}

