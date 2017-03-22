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
    
    
    //
    // MARK: - Helper
    fileprivate var selectedTable: Table? {return self.tableStackView.selectedTable}
    fileprivate var selectedTableIndex: Int {return self.tableStackView.selectedTableIndex}
    fileprivate var visibleGridDatabaseView: GridDatabaseView {
        return self.gridDatabaseViews[self.selectedTableIndex]
    }
    
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
        NotificationManager.observeNotificationType(.stackTableStateChanged, observer: self, selector: #selector(self.stackTableStateChangedNotification(noti:)), object: nil)
    }
    
    @objc func stackTableStateChangedNotification(noti: Notification) {
        
        // Update stack view
        self.tableStackView.updateStackView()
        
        // Grid
        let dict = noti.userInfo as! [String: Bool]
        let isNewTap = dict["openInNewTap"] ?? true
        self.handleGirdView(isOpenNewTab: isNewTap)
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
}

//
// MARK: - Grid View
extension ContentDatabaseController {
    
    fileprivate func handleGirdView(isOpenNewTab: Bool) {
        guard let selectedTable = self.selectedTable else {return}
        
        // Hide all
        self.hideAllGridView()
        
        // Handle
        if isOpenNewTab {
            let gridView = GridDatabaseView.viewFromNib()!
            gridView.configureGridDatabase(with: .individually(selectedTable))
            self.gridDatabaseViews.append(gridView)
            self.addGridView(gridView)
        } else {
            let gridView = self.visibleGridDatabaseView
            gridView.configureGridDatabase(with: .individually(selectedTable))
            gridView.isHidden = false
        }
    }
    
    fileprivate func addGridView(_ gridView: GridDatabaseView) {
        guard gridView.superview == nil else {return}
        
        gridView.translatesAutoresizingMaskIntoConstraints = false
        self.contentContainerView.addSubview(gridView)
        gridView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentContainerView).inset(NSEdgeInsetsZero)
        }
        
        gridView.isHidden = false
    }
    
    fileprivate func hideAllGridView() {
        for gridView in self.gridDatabaseViews {
            gridView.isHidden = true
        }
    }
}

//
// MARK: - Table Stack
extension ContentDatabaseController: TableStackViewDelegate {
    
    func TableStackViewDidSelectedTable(_ table: Table) {
        self.output?.didSwitchTab(with: table)
    }
}
