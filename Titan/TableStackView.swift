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
    var stackTables: [Table] {return mainStore.state.detailDatabaseState!.stackTables}
    var selectedTable: Table? {return mainStore.state.detailDatabaseState!.selectedTable}
    var selectedTableIndex: Int {
        guard let selectedTable = self.selectedTable else {return -1}
        for (i,e) in self.stackTables.enumerated() {
            if e.tableName! == selectedTable.tableName! {
                return i
            }
        }
        return -1
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
    
    //
    // MARK: - Public
    
    // Update layout
    func updateStackView() {
        Logger.info("updateStackView")
        self.collectionView.reloadData()
    }
    
    // Determine if table is in stack or not
    func isTableInStack(for table: Table) -> Bool {
        let filter = self.stackTables.filter { _table -> Bool in
            return _table.tableName! == table.tableName!
        }
        return filter.count > 0
    }
}

extension TableStackView: XIBInitializable {
    typealias T = TableStackView
}

extension TableStackView: NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.stackTables.count + 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        // Last cell -> Add cell
        if indexPath.item == self.stackTables.count {
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
        flowLayout.estimatedItemSize = NSSize(width: 250, height: 44)
        flowLayout.sectionHeadersPinToVisibleBounds = false
        flowLayout.sectionFootersPinToVisibleBounds = false
        flowLayout.minimumInteritemSpacing = 0
        self.collectionView.collectionViewLayout = flowLayout
        
//        self.collectionView.minItemSize = NSSize(width: 44, height: 44)
//        self.collectionView.maxItemSize = NSSize.zero
        
        // Reload
        self.collectionView.reloadData()
    }
    
    fileprivate func addStackTableCell(with collectionView: NSCollectionView, indexPath: IndexPath) -> AddTableStackCell {
        let cell = collectionView.makeItem(withIdentifier: AddTableStackCell.identifierView, for: indexPath) as! AddTableStackCell
        return cell
    }
    
    fileprivate func stackTableCell(with collectionView: NSCollectionView, indexPath: IndexPath) -> StackTableCell {
        let cell = collectionView.makeItem(withIdentifier: StackTableCell.identifierView, for: indexPath) as! StackTableCell
        
        let table = self.stackTables[indexPath.item]
        let isSelected = indexPath.item == self.selectedTableIndex
        cell.configureCell(with: table, isSelected: isSelected)
        
        return cell
    }
}
