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
    var collectionView: NSCollectionView! {didSet{self.setupCollectionView()}}
    fileprivate var tables: [Table] {
        return mainStore.state.detailDatabaseState!.tables
    }
    
    //
    // MARK: - Public
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
        
    }
    
    fileprivate func tableCell(with collectionView: NSCollectionView, indexPath: IndexPath) -> TableRowCell {
        
    }
}

extension TablesDataSource: NSCollectionViewDelegate {
    
}
