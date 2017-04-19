//
//  ConnectionListDataSource.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/5/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore
import RxSwift

//
// MARK: - ConnectionListDataSource
class ConnectionListDataSource: BaseCollectionViewDataSource {
    
    //
    // MARK: - Variable
    var createDatabasePublisher = PublishSubject<GroupConnectionObj>()
    
    //
    // MARK: - Init
    override init(collectionView: NSCollectionView) {
        super.init(collectionView: collectionView)
        
        self.setupCollectionView()
    }
    
    //
    // MARK: - Override
    public override func numberOfSections(in collectionView: NSCollectionView) -> Int {
        guard let delegate = self.delegate else {return 0}
        return delegate.CommonDataSourceNumberOfSection()
    }
    
    public override func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let delegate = self.delegate else {return 0}
        return delegate.CommonDataSourceNumberOfItem(at: section)
    }
    
    override func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        guard let delegate = self.delegate else {return NSCollectionViewItem()}
    
        // Return cell
        let groupObj = delegate.CommonDataSourceItem(at: indexPath) as! GroupConnectionObj
        let databaseObj = groupObj.databases[indexPath.item]
        return self.getConnectionCell(with: databaseObj, for: collectionView, indexPath: indexPath)
    }
    
    override func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> NSView {
        guard let delegate = self.delegate else {return NSView()}
        
        // Return header
        let groupObj = delegate.CommonDataSourceItem(at: indexPath) as! GroupConnectionObj
        return self.getGroupConnectionHeader(with: groupObj, for: collectionView, indexPath: indexPath)
    }
    
    override func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        guard let delegate = self.delegate else {return}
        
        // Select
        delegate.didSelectItem(at: indexPaths)
    }
}

//
// MARK: - Private
extension ConnectionListDataSource {
    
    fileprivate func setupCollectionView() {
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // Register
        //self.collectionView.registerCell(ConnectionCell.self)
        self.collectionView.register(NSNib(nibNamed: "ConnectionCell", bundle: nil), forItemWithIdentifier: "ConnectionCell")
        self.collectionView.registerSupplementary(ConnectionGroupCell.self, kind: NSCollectionElementKindSectionHeader)
        
        // Flow layout
        let flowLayout = AutosizeVerticalFlowLayout()
        self.collectionView.collectionViewLayout = flowLayout
    }
}

//
// MARK: - Private
extension ConnectionListDataSource {
    
    /// Database cell
    fileprivate func getConnectionCell(with databaseObj: DatabaseObj, for collectionView: NSCollectionView, indexPath: IndexPath) -> NSCollectionViewItem {
        let cell = collectionView.makeItem(withIdentifier: ConnectionCell.identifierView, for: indexPath) as! ConnectionCell
        //cell.delegate = self
        cell.configureCell(with: databaseObj)
        
        return cell
    }
    
    /// Group Connection header
    fileprivate func getGroupConnectionHeader(with groupConnectionObj: GroupConnectionObj, for collectionView: NSCollectionView, indexPath: IndexPath) -> NSView {
        let header = collectionView.makeSupplementaryView(ofKind: NSCollectionElementKindSectionHeader, withIdentifier: ConnectionGroupCell.identifierView, for: indexPath) as! ConnectionGroupCell
        header.configureCellWith(groupConnectionObj: groupConnectionObj)
        header.delegate = self
        return header
    }
}

extension ConnectionListDataSource: ConnectionGroupCellDelegate {
    func ConnectionGroupCellShouldCreateNewDatabase(into group: GroupConnectionObj) {
        self.createDatabasePublisher.onNext(group)
    }
}
