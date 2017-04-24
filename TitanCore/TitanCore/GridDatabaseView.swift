//
//  GridDatabaseView.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/20/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import SwiftyPostgreSQL
import RxSwift

open class GridDatabaseView: NSView {

    //
    // MARK: - OUTLET
    @IBOutlet weak var tableView: TitanTableView!
    @IBOutlet weak var containerStatusBarView: NSView!
    
    //
    // MARK: - Variable
    public var table: Table! {didSet{
        self.initViewModel()
        self.binding()
        }}
    fileprivate var viewModel: GridDatabaseViewModel!
    fileprivate var disposeBag = DisposeBag()
    
    //
    // MARK: - Init
    public class func viewNib(with table: Table) -> GridDatabaseView {
        let view = GridDatabaseView.viewFromNib()!
        view.table = table
        return view
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        //
        self.initCommon()
    }
}

//
// MARK: - Private
extension GridDatabaseView {
    
    fileprivate func initCommon() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    fileprivate func initViewModel() {
        self.viewModel = GridDatabaseViewModel(with: self.table)
    }
    
    class func viewFromNib() -> GridDatabaseView? {
        
        var topViews: NSArray = []
        let xib = NSNib(nibNamed: "GridDatabaseView", bundle: Bundle(identifier: "com.fe.nghiatran.TitanCore"))
        let _ = xib?.instantiate(withOwner: self, topLevelObjects: &topViews)
        
        for subView in topViews {
            if let innerView = subView as? GridDatabaseView {
                return innerView
            }
        }
        
        return nil
    }
    
    fileprivate func binding() {
        
        // Fetch default query
        self.viewModel.input.fetchDatabaseFromTablePublisher.onNext()
        
        // Reload if have new query Result
        self.viewModel.output.queryResult.asDriver().drive(onNext: { _ in
            
            // Setup colums and data
            self.setupDataForTableView()
            
            // Reload
            self.tableView.reloadData()
        })
        .addDisposableTo(self.disposeBag)
    }
}

//
// MARK: - Grid view
extension GridDatabaseView {
    
    fileprivate func setupDataForTableView() {
        
        // Setup new columns
        self.tableView.setupColumns(self.viewModel.queryResult.value.columns)
        
        // Enable save
        self.autosaveColumnsWidth()
    }
    
    fileprivate func autosaveColumnsWidth() {
        let tableName = self.viewModel.query.rawString
        
        // Save
        self.tableView.autosaveName = tableName
        self.tableView.autosaveTableColumns = true
        
        // Calculate size
        self.tableView.makeColumnsFitContents()
    }
}

//
// MARK: - NSTableViewDataSource
extension GridDatabaseView: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.rows.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let tableColumn = tableColumn as? TitanTableColumn else {return nil}
        
        let tableCellType = tableColumn.tableViewCellType
        switch tableCellType {
        case .switchButton:
            return self.switchCellCell(tableColumn: tableColumn, row: row)
            
        case .textField:
            return self.textFieldCellView(tableColumn: tableColumn, row: row)
            
        }
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        var rowView = tableView.make(withIdentifier: ContentRowView.identifierView, owner: self) as? ContentRowView
        
        if rowView == nil {
            rowView = ContentRowView()
            rowView?.identifier = ContentRowView.identifierView
        }
        
        return rowView
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 17
    }
    
    private func switchCellCell(tableColumn: TitanTableColumn, row: Int) -> BoolCellView {
        var cell = self.tableView.make(withIdentifier: tableColumn.identifier, owner: self) as? BoolCellView
        if cell == nil {
            cell = BoolCellView.viewWithIdentifier(tableColumn.identifier)
        }
        
        cell!.configureCell()
        return cell!
    }
    
    private func textFieldCellView(tableColumn: TitanTableColumn, row: Int) -> TextFieldCellView {
        var cell = self.tableView.make(withIdentifier: tableColumn.identifier, owner: self) as? TextFieldCellView
        if cell == nil {
            cell = TextFieldCellView.viewWithIdentifier(tableColumn.identifier)
        }
        
        // Configure
        let col = tableColumn.column!
        let field = self.field(at: col, row: row)
        cell!.configureCell(with: field, column: col)
        return cell!
    }
}

//
// MARK: - NSTableViewDelegate
extension GridDatabaseView: NSTableViewDelegate {
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        // Update status bar
        let set = self.tableView.selectedRowIndexes
        self.delegate?.DatabaseContentDidSelectionChanged(set, rowAffect: self.numberRowEffect)
    }
}

