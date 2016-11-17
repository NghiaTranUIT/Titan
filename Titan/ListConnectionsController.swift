//
//  ListConnectionsViewController.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift

protocol ListConnectionsControllerOutput {
    func fetchConnections(action: FetchConnectionsAction)
    func selectConnection(action: SelectConnectionAction)
}

protocol ListConnectionsControllerInput: class {
    func displayConnections(_ connections: [DatabaseObj])
}

class ListConnectionsController: BaseViewController {

    //
    // MARK: - Variable
    var output: ListConnectionsControllerOutput!
    
    // Connection
    fileprivate var connections: [DatabaseObj] {
        return []
    }
    
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var addConnectionBtn: NSButton!
    
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initCommon() {
        self.initTableView()
    }
    
    private func initTableView() {
        
        // Data Source
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // Register
        self.tableView.registerView(ConnectionCell.self)
        
        // Trigger selected
        self.tableView.target = self
        self.tableView.doubleAction = #selector(ListConnectionsController.openDatabaseClicked(sender:))
    }
    
    override func setupActions() {
        
        // Fetch all connection
        let fetchAllConnectionAction = FetchConnectionsAction()
        self.output.fetchConnections(action: fetchAllConnectionAction)
    }
}

//
// MARK: - Private
extension ListConnectionsController {
    @objc fileprivate func openDatabaseClicked(sender: AnyObject) {
        
        // Prevent select multi connections
        let selectedRow = self.tableView.selectedRow
        guard self.tableView.selectedRow == 1 else {
            return
        }
        
        // Selection
        let selectedDb = self.connections[selectedRow]
        let action = SelectConnectionAction(selectedConnection: selectedDb)
        self.output.selectConnection(action: action)
    }
}


//
// MARK: - ViewModel Delegate
extension ListConnectionsController: ListConnectionsControllerInput {
    func displayConnections(_ connections: [DatabaseObj]) {
        self.tableView.reloadData()
    }
}

extension ListConnectionsController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.connections.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 30
    }
}

extension ListConnectionsController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        // Return if col is not first col
        guard tableColumn == tableView.tableColumns[0] else {
            return nil
        }
        
        // Get model
        let databaseObj = self.connections[row]
        return self.connectionListCell(with: databaseObj, for: tableView)
    }
    
    private func connectionListCell(with databaseObj: DatabaseObj, for tableView: NSTableView) -> NSView {
        let cell = tableView.make(withIdentifier: ConnectionCell.identifierView, owner: nil) as! ConnectionCell
        cell.configureCell(with: databaseObj)
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
    }
}
