//
//  DataListController.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import SnapKit
import SwiftyPostgreSQL

protocol ContentDatabaseControllerOutput {
    func didSwitchTab(with table: Table)
}

class ContentDatabaseController: NSViewController {

    //
    // MARK: - Variable
    fileprivate var tableStackView: TableStackView!
    fileprivate var gridDatabaseViews: [GridDatabaseView] = []
    fileprivate var statusBarView: StatusBarView!
    
    
    //
    // MARK: - Helper
    fileprivate var selectedTable: Table? {return self.tableStackView.selectedTable}
    fileprivate var selectedTableIndex: Int {return self.tableStackView.selectedTableIndex}
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var stackContainerView: NSView!
    @IBOutlet weak var contentContainerView: NSView!
    @IBOutlet weak var containerStatusBarView: NSView!
    
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
        self.initStatusBarView()
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
        
        self.tableStackView = TableStackView.viewFromNib()
        self.tableStackView.delegate = self
        self.tableStackView.configureLayoutWithView(self.stackContainerView)
    }
    
    fileprivate func initStatusBarView() {
        self.statusBarView = StatusBarView.viewFromNib()
        self.statusBarView.configureLayoutWithView(self.containerStatusBarView)
    }
}

//
// MARK: - Grid View
extension ContentDatabaseController {
    
    fileprivate func handleGirdView() {
        guard let selectedTable = self.selectedTable else {return}
        
        let filter = self.gridDatabaseViews.filter { gridView -> Bool in
            return gridView.table == selectedTable
        }
        
        // Remove all
        for gridView in self.gridDatabaseViews {
            gridView.removeFromSuperview()
        }
        
        // Add
        if let gridView = filter.first {
            self.addGridView(gridView)
        } else {
            let gridView = GridDatabaseView.viewFromNib()!
            gridView.configureGridDatabase(with: .individually(selectedTable))
            self.gridDatabaseViews.append(gridView)
            self.addGridView(gridView)
        }
        
        // Filter again
        // to removed unncessary view + pointer
        let removeViews = self.gridDatabaseViews.filter { (innerGridView) -> Bool in
            return !self.tableStackView.isTableInStack(for: innerGridView.table!)
        }
        for removeView in removeViews {
            removeView.removeFromSuperview()
            if let index = self.gridDatabaseViews.index(of: removeView) {
                self.gridDatabaseViews.remove(at: index)
            }
        }
    }
    
    fileprivate func addGridView(_ gridView: GridDatabaseView) {
        guard gridView.superview == nil else {return}
        
        gridView.translatesAutoresizingMaskIntoConstraints = false
        self.contentContainerView.addSubview(gridView)
        gridView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentContainerView).inset(NSEdgeInsetsZero)
        }
    }
}

extension ContentDatabaseController: TableStackViewDelegate {
    func TableStackViewDidSelectedTable(_ table: Table) {
        self.output?.didSwitchTab(with: table)
    }
}
