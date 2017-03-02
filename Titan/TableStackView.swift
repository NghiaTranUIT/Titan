//
//  DatabaseStackView.swift
//  Titan
//
//  Created by Nghia Tran on 2/3/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import SwiftyPostgreSQL

protocol TableStackViewDelegate: class {
    func TableStackViewDidSelectedTable(_ table: Table)
}

class TableStackView: NSView {

    //
    // MARK: - Variable
    weak var delegate: TableStackViewDelegate?
    var stackTables: [Table] {return mainStore.state.detailDatabaseState!.stackTables}
    var selectedTable: Table? {return mainStore.state.detailDatabaseState!.selectedTable}
    var selectedTableIndex: Int {
        guard let selectedTable = self.selectedTable else {return -1}
        for (i,e) in self.stackTables.enumerated() {
            if e == selectedTable {
                return i
            }
        }
        return -1
    }
    var previousTableIndex = -1
    
    fileprivate lazy var resizeCell: StackTableCell = {
        let cell = StackTableCell.viewFromNib()!
        return cell
    }()
    fileprivate lazy var indicatorBarView: NSView = self.initIndicatorBarView()
    
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
        self.collectionView.reloadData()
        self.animateIndicatorView()
    }
    
    // Determine if table is in stack or not
    func isTableInStack(for table: Table) -> Bool {
        let filter = self.stackTables.filter { _table -> Bool in
            return _table == table
        }
        return filter.count > 0
    }
    
    fileprivate func animateIndicatorView() {
        
        // Delay 0.1 after collection reloadData()
        // If we call after reloadData(). For unknown reason, the collectionView hasn't reloaded yet
        // => Can't get visible cell
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            guard let selectedTable = self.selectedTable else {return}
            guard let selectedCell = self.stackCellWithTable(selectedTable) else {return}
            
            // Update
            let newFrame = NSRect(x: selectedCell.view.frame.origin.x, y: 0, width: selectedCell.view.frame.width, height: 2)
            
            if self.previousTableIndex == -1 || self.previousTableIndex == self.selectedTableIndex {
                // No animate
                self.indicatorBarView.frame = newFrame
            }
            else {
                NSAnimationContext.runAnimationGroup({ (context) in
                    context.duration = 0.13
                    self.indicatorBarView.animator().frame = newFrame
                }, completionHandler: nil)
            }
            
            self.previousTableIndex = self.selectedTableIndex
        }

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
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        
        if indexPath.item == self.stackTables.count {
            return NSSize(width: 32, height: 32)
        }
        
        // Stack cell
        let table = self.stackTables[indexPath.item]
        let width = self.resizeCell.minimumWidthCell(with: table)
        return NSSize(width: width, height: 32)
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
        flowLayout.itemSize = NSSize(width: 100, height: 32)
        flowLayout.sectionHeadersPinToVisibleBounds = false
        flowLayout.sectionFootersPinToVisibleBounds = false
        flowLayout.minimumInteritemSpacing = 0
        self.collectionView.collectionViewLayout = flowLayout
        
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
        cell.delegate = self
        cell.configureCell(with: table, isSelected: isSelected)
        
        return cell
    }
    
    fileprivate func initIndicatorBarView() -> NSView {
        let barView = NSView()
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.backgroundColor = NSColor(hexString: "#9b59b6")
        barView.wantsLayer = true
        barView.layerContentsRedrawPolicy = .onSetNeedsDisplay
        self.addSubview(barView)
        return barView
    }
    
    fileprivate func stackCellWithTable(_ table: Table) -> StackTableCell? {
        for cell in self.collectionView.visibleItems() {
            guard let cell = cell as? StackTableCell else {continue}
            if cell.table == table {
                return cell
            }
        }
        return nil
    }
    
}

//
// MARK: - StackTableCellDelegate
extension TableStackView: StackTableCellDelegate {
    
    func StackTableCellDidSelectTable(_ table: Table) {
        self.delegate?.TableStackViewDidSelectedTable(table)
    }
}
