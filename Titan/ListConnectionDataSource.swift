//
//  ListConnectionDataSource.swift
//  Titan
//
//  Created by Nghia Tran on 1/7/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import RxSwift
import RealmSwift

protocol ListConnectionDataSourceDelegate: class {
    func ListConnectionDataSourceDidSelectedDatabase(_ databaseObj: DatabaseObj)
}

class ListConnectionDataSource: NSObject {
    
    //
    // MARK: - Variable
    weak var delegate: ListConnectionDataSourceDelegate?
    fileprivate var notificationToken: NotificationToken? = nil
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
        self.notificationToken?.stop()
    }
    
    /// Obserable
    fileprivate func initCommon() {
        
        // Group connection
        self.notificationToken = mainStore.state.connectionState?.groupConnections
        .addNotificationBlock({[weak self] changed in
            guard let `self` = self else {return}
            guard let collectionView = self.collectionView else {return}
            
            switch changed {
            case .initial:
                collectionView.reloadData()
            
            case .error(let error):
                Logger.error(error)
                
            case .update(_, _, _, _):
                collectionView.reloadData()
            }
        })
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
extension ListConnectionDataSource {
    
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
        return header
    }
}


//
// MARK: - Collection View Data Source
extension ListConnectionDataSource: NSCollectionViewDataSource {
    
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
extension ListConnectionDataSource: NSCollectionViewDelegate {
    
    /// Did Select
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        
        guard let indexPath = indexPaths.first else {return}
        
        // Select
        let group = self.groupConnections[indexPath.section]
        let databaseObj = group.databases[indexPath.item]
        self.delegate?.ListConnectionDataSourceDidSelectedDatabase(databaseObj)
    }
}


//
// MARK: - ConnectionCellDelegate
extension ListConnectionDataSource: ConnectionCellDelegate {
    func ConnectionCellDidSelectedCell(sender: ConnectionCell, databaseObj: DatabaseObj, isSelected: Bool) {
        self.delegate?.ListConnectionDataSourceDidSelectedDatabase(databaseObj)
    }
}

