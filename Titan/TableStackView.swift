//
//  DatabaseStackView.swift
//  Titan
//
//  Created by Nghia Tran on 2/3/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import TitanKit

class TableStackView: NSView {

    //
    // MARK: - Variable
    var stackTables: [Table] {
        return mainStore.state.detailDatabaseState!.stackTables
    }
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var collectionView: NSCollectionView!
    
    
    //
    // MARK: - View Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Base
        self.initBaseAbility()
    }
    
    override func initCommon() {
        
        // Setup Collection
        self.initStackView()
    }
}

extension TableStackView: NSCollectionViewDataSource, NSCollectionViewDelegate {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.stackTables.count + 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        // Last cell -> Add cell
        if indexPath.item == self.stackTables.count - 1 {
            return self.addStackTableCell(with: collectionView, indexPath: indexPath)
        }
        
        // StackTable Cell
        return self.stackTableCell(with: collectionView, indexPath: indexPath)
    }
}

//
// MARK: - Private
extension TableStackView {
    fileprivate func initStackView() {
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // Register
        self.collectionView.registerCell(AddTableStackCell.self)
        self.collectionView.registerCell(StackTableCell.self)
        
        // Flow layout
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = NSSize(width: 150, height: 44)
        flowLayout.estimatedItemSize = NSSize.zero
        flowLayout.sectionHeadersPinToVisibleBounds = false
        flowLayout.sectionFootersPinToVisibleBounds = false
        self.collectionView.collectionViewLayout = flowLayout
        
        self.collectionView.minItemSize = NSSize(width: 44, height: 44)
        self.collectionView.maxItemSize = NSSize.zero
        
        // Reload
        self.collectionView.reloadData()
    }
    
    fileprivate func addStackTableCell(with collectionView: NSCollectionView, indexPath: IndexPath) -> AddTableStackCell {
        
    }
    
    fileprivate func stackTableCell(with collectionView: NSCollectionView, indexPath: IndexPath) -> StackTableCell {
        
    }
}
