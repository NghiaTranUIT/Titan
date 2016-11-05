//
//  ListConnectionsViewController.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa

class ListConnectionsController: BaseViewController {

    //
    // MARK: - Variable
    fileprivate lazy var viewModel = {return ListConnectionViewModel()}()
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var tableView: NSTableView!
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initCommon() {
        
    }
    
    private func initTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // Trigger selected
        self.tableView.target = self
        self.tableView.doubleAction = #selector(ListConnectionsController.openDatabaseClicked(sender:))
    }
    
    override func setupBinding() {
        
        // Fetch connections
        self.viewModel.fetchConnections()
    }
}

//
// MARK: - Private
extension ListConnectionsController {
    @objc fileprivate func openDatabaseClicked(sender: AnyObject) {
        
        // Prevent select multi connections
        guard self.tableView.selectedRow == 1 else {
            return
        }
        
        // Bind to View model
        let selectedIndexPath = IndexPath(item: self.tableView.selectedRow, section: 0)
        let selectedItemObserable = Variable<IndexPath>(selectedIndexPath)
        viewModel.selectedIndexPath = selectedItemObserable.asObservable()
    }
}

extension ListConnectionsController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.viewModel.numberOfConnection()
    }
}

extension ListConnectionsController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        // Return if col is not first col
        guard tableColumn == tableView.tableColumns[0] else {
            return nil
        }
        
        // Get model
        let databaseObj = self.viewModel.connection(atRow: row)
        return self.connectionListCell(with: databaseObj, for: tableView)
    }
    
    private func connectionListCell(with databaseObj: DatabaseObj, for tableView: NSTableView) -> NSView {
        let cell = tableView.make(withIdentifier: ConnectionCell.viewID, owner: nil) as! ConnectionCell
        
        cell.configureCell(with: databaseObj)
        
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
    }
}
