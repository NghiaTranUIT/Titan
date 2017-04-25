//
//  StackTableView.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/20/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import RxSwift
import SwiftyPostgreSQL

open class StackTableView: NSView {
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var collectionView: NSCollectionView!
    fileprivate lazy var indicatorBarView: NSView = self.initIndicatorBarView()
    fileprivate lazy var resizeCell: StackTableCell = {
        let cell = StackTableCell.viewFromNib(with: .core)!
        return cell
    }()
    
    //
    // MARK: - Variable
    fileprivate var viewModel: StackTableViewModel!
    fileprivate var disposeBag = DisposeBag()
    
    //
    // MARK: - Init
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        //
        self.initCommon()
        self.initViewModel()
        self.initCollectionView()
        self.binding()
    }
    
    deinit {
        Logger.info("GridDatabaseView Deinit")
    }
}

//
// MARK: - XIBInitializable
extension StackTableView: XIBInitializable {
    public typealias T = StackTableView
}

//
// MARK: - Private
extension StackTableView {
    
    fileprivate func initCommon() {
        
    }
    
    fileprivate func initViewModel() {
        self.viewModel = StackTableViewModel()
    }
    
    fileprivate func binding() {
        
        // Reload
        self.viewModel.output.stackTableDriver.drive(onNext: {[weak self] _ in
            guard let `self` = self else {return}
            self.collectionView.reloadData()
            
            // Animate bottom bar
            self.animateIndicatorView()
        })
        .addDisposableTo(self.disposeBag)
    }
    
    fileprivate func initCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // Register
        self.collectionView.registerCell(AddTableStackCell.self, bundle: .core)
        self.collectionView.registerCell(StackTableCell.self, bundle: .core)
        
        // Flow layout
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = NSSize(width: 100, height: 32)
        flowLayout.sectionHeadersPinToVisibleBounds = false
        flowLayout.sectionFootersPinToVisibleBounds = false
        flowLayout.minimumInteritemSpacing = 0
        self.collectionView.collectionViewLayout = flowLayout
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
}

extension StackTableView: NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout {
    
    public func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.stackTableVariable.value.count + 1
    }
    
    public func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        // Last cell -> Add cell
        if indexPath.item == self.viewModel.stackTableVariable.value.count {
            return self.addStackTableCell(with: collectionView, indexPath: indexPath)
        }
        
        // StackTable Cell
        return self.stackTableCell(with: collectionView, indexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        
        if indexPath.item == self.viewModel.stackTableVariable.value.count {
            return NSSize(width: 32, height: 32)
        }
        
        // Stack cell
        let table = self.viewModel.stackTableVariable.value[indexPath.item]
        let width = self.resizeCell.minimumWidthCell(with: table)
        return NSSize(width: width, height: 32)
    }
    
    fileprivate func addStackTableCell(with collectionView: NSCollectionView, indexPath: IndexPath) -> AddTableStackCell {
        let cell = collectionView.makeItem(withIdentifier: AddTableStackCell.identifierView, for: indexPath) as! AddTableStackCell
        return cell
    }
    
    fileprivate func stackTableCell(with collectionView: NSCollectionView, indexPath: IndexPath) -> StackTableCell {
        let cell = collectionView.makeItem(withIdentifier: StackTableCell.identifierView, for: indexPath) as! StackTableCell
        
        let table = self.viewModel.stackTableVariable.value[indexPath.item]
        let isSelected = indexPath.item == self.viewModel.output.selectedIndex
        //cell.delegate = self
        cell.configureCell(with: table, isSelected: isSelected)
        
        return cell
    }
    
    public func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        guard let selectedIndexPath = indexPaths.first else {return}
        guard selectedIndexPath.item != self.viewModel.stackTableVariable.value.count else {return}
        
        // Selected table
        self.viewModel.input.selectedTablePublisher.onNext(selectedIndexPath)
    }
}

extension StackTableView {
    
    // Determine if table is in stack or not
    func isTableInStack(for table: Table) -> Bool {
        let filter = self.viewModel.output.stackTableVariable.value.filter { _table -> Bool in
            return _table == table
        }
        return filter.count > 0
    }
    
    fileprivate func animateIndicatorView() {
        
        // Delay 0.1 after collection reloadData()
        // If we call after reloadData(). For unknown reason, the collectionView hasn't reloaded yet
        // => Can't get visible cell
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            guard let selectedTable = self.viewModel.output.selectedTableVariable.value else {return}
            guard let selectedCell = self.stackCellWithTable(selectedTable) else {return}
            
            // Update
            let newFrame = NSRect(x: selectedCell.view.frame.origin.x, y: 0, width: selectedCell.view.frame.width, height: 2)
            
            if self.viewModel.input.previousTableIndex == -1 ||
                self.viewModel.input.previousTableIndex == self.viewModel.output.selectedIndex {
                // No animate
                self.indicatorBarView.frame = newFrame
            }
            else {
                NSAnimationContext.runAnimationGroup({ (context) in
                    context.duration = 0.13
                    self.indicatorBarView.animator().frame = newFrame
                }, completionHandler: nil)
            }
            
            self.viewModel.previousTableIndex = self.viewModel.output.selectedIndex
        }
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
