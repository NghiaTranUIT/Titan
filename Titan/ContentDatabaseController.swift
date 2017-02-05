//
//  DataListController.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import SnapKit
import TitanKit

protocol ContentDatabaseControllerOutput {
    
}

class ContentDatabaseController: NSViewController {

    //
    // MARK: - Variable
    fileprivate var tableStackView: TableStackView!
    fileprivate var gridDatabaseViews: [GridDatabaseView] = []
    
    //
    // MARK: - Helper
    fileprivate var selectedTable: Table? {return self.tableStackView.selectedTable}
    fileprivate var selectedTableIndex: Int {return self.tableStackView.selectedTableIndex}
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var stackContainerView: NSView!
    @IBOutlet weak var contentContainerView: NSView!
    
    //
    // MARK: - Variable
    var output: ContentDatabaseControllerOutput?
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Base
        self.initBaseAbility()
        
        // Init
        self.initStackView()
    }
    
    deinit {
        NotificationManager.removeAllObserve(self)
    }
    
    override func initCommon() {
        ContentDatabaseConfig.shared.configure(viewController: self)

    }
    
    override func initObserver() {
        NotificationManager.observeNotificationType(.stackTableStateChanged, observer: self, selector: #selector(self.stackTableStateChangedNotification), object: nil)
    }
    
    @objc func stackTableStateChangedNotification() {
        
        // Update stack view
        self.tableStackView.updateStackView()
        
        // Grid
        self.handleGirdView()
    }
}

extension ContentDatabaseController: ContentDatabasePresenterOutput {
    
}

//
// MARK: - Private
extension ContentDatabaseController {
    
    fileprivate func initStackView() {
        var topViews: NSArray = []
        let _ = TableStackView.xib()!.instantiate(withOwner: self, topLevelObjects: &topViews)
        
        // Init
        for view in topViews {
            if let innerView = view as? TableStackView {
                self.tableStackView = innerView
                break
            }
        }
        
        // Add subview
        self.tableStackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackContainerView.addSubview(self.tableStackView)
        self.tableStackView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.stackContainerView).inset(NSEdgeInsetsZero)
        }
    }
    
    fileprivate func initContentDatabase() {
        
    }

}

//
// MARK: - Grid View
extension ContentDatabaseController {
    
    fileprivate func handleGirdView() {
        guard let selectedTable = self.selectedTable else {return}
        
        let filter = self.gridDatabaseViews.filter { gridView -> Bool in
            return gridView.table.tableName! == selectedTable.tableName!
        }
        
        // Remove all
        for gridView in self.gridDatabaseViews {
            if gridView.table.tableName! != selectedTable.tableName! {
                gridView.removeFromSuperview()
            }
        }
        
        // Add
        if let gridView = filter.first {
            self.addGridView(gridView)
        } else {
            var topViews: NSArray = []
            let _ = GridDatabaseView.xib()?.instantiate(withOwner: self, topLevelObjects: &topViews)
            
            for subView in topViews {
                if let innerView = subView as? GridDatabaseView {
                    innerView.configureGrid(with: self.selectedTable!)
                    self.gridDatabaseViews.append(innerView)
                    self.addGridView(innerView)
                }
            }
        }
    }
    
    fileprivate func addGridView(_ gridView: GridDatabaseView) {
        gridView.translatesAutoresizingMaskIntoConstraints = false
        self.contentContainerView.addSubview(gridView)
        gridView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.stackContainerView).inset(NSEdgeInsetsZero)
        }
    }
}
