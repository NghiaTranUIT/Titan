//
//  ColumnsDataSource.swift
//  Titan
//
//  Created by Nghia Tran on 2/3/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import TitanKit

class TablesDataSource: NSObject {
    
    //
    // MARK: - Variable
    fileprivate var isFirstTime = true
    var collectionView: NSCollectionView! {didSet{self.setupCollectionView()}}
    fileprivate var tables: [Table] {
        return mainStore.state.detailDatabaseState!.tables
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
        NotificationManager.observeNotificationType(.tableStateChanged, observer: self, selector: #selector(self.tableStateChanged), object: nil)
    }
    
    //
    // MARK: - Public
    func setupCollectionView() {
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // Register
        self.collectionView.registerCell(PlaceholderCollectionCell.self)
        self.collectionView.registerCell(TableRowCell.self)
        
        // Flow layout
        let flowLayout = NSCollectionViewFlowLayout()
        let width = collectionView.frame.size.width
        flowLayout.itemSize = CGSize(width: width, height: 32)
        flowLayout.sectionInset = NSEdgeInsetsMake(0, 0, 0, 0)
        flowLayout.sectionHeadersPinToVisibleBounds = false
        flowLayout.sectionFootersPinToVisibleBounds = false
        self.collectionView.collectionViewLayout = flowLayout
        
        // Reload
        self.collectionView.reloadData()
    }
    
    @objc func tableStateChanged() {
        self.collectionView.reloadData()
    }
}

extension TablesDataSource: NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // placeholderCell cell
        if self.tables.count == 0 {
            return 1
        }
        
        return self.tables.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        // Placeholder
        if self.tables.count == 0 {
            return self.placeholderCell(with: collectionView, indexPath: indexPath)
        }
        
        // table
        return self.tableCell(with: collectionView, indexPath: indexPath)
    }
    
    fileprivate func placeholderCell(with collectionView: NSCollectionView, indexPath: IndexPath) -> PlaceholderCollectionCell {
        let cell = collectionView.makeItem(withIdentifier: PlaceholderCollectionCell.identifierView, for: indexPath) as! PlaceholderCollectionCell
        cell.configurePlaceholderCell(with: "No tables", isShowLoader: self.isFirstTime)
        return cell
    }
    
    fileprivate func tableCell(with collectionView: NSCollectionView, indexPath: IndexPath) -> TableRowCell {
        let cell = collectionView.makeItem(withIdentifier: TableRowCell.identifierView, for: indexPath) as! TableRowCell
        let table = self.tables[indexPath.item]
        cell.configureCell(with: table)
        return cell
    }
}

extension TablesDataSource: NSCollectionViewDelegate {
    
}
